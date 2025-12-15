module EvalPar (bestMovePar) where

import Board
import System.Random
import Data.Function (on)
import Data.List
import Control.Parallel.Strategies

-- run a simulation and return the winner
simulate :: Board -> Player -> StdGen -> Maybe Player
simulate board player gen =
    case checkWin board of
        Just winner -> Just winner
        Nothing ->
            let moves = availableMoves board
            in if moves == [] then Nothing
            else
                let (moveIndex, newGen) = randomR (0, length moves - 1) gen
                    newBoard = applyMove board player (moves !! moveIndex)
                in simulate newBoard (otherPlayer player) newGen

-- run a chunk of simulations for a given move
simulateChunk :: Board -> Player -> Int -> [StdGen] -> Int
simulateChunk board player move gens =
    let newBoard = applyMove board player move
        results = map (simulate newBoard (otherPlayer player)) gens
    in length (filter (== Just player) results)

-- split list into length n chunks
splitList :: [a] -> Int -> [[a]]
splitList [] _ = []
splitList li n = take n li : splitList (drop n li) n

-- count simulation wins for each move
evalMove :: Board -> Player -> Int -> Int -> Int -> (Int, Int)
evalMove board player simulations chunkSize move =
    let gens = [mkStdGen s | s <- [1..simulations]]
        genChunks = splitList gens chunkSize
        chunkWins = parMap rdeepseq (simulateChunk board player move) genChunks
        totalWins = sum chunkWins
    in (move, totalWins)

-- return the move with the most wins
bestMovePar :: Board -> Player -> Int -> Int -> Int
bestMovePar board player simulations chunkSize =
    let moves = availableMoves board
        winCounts = map (evalMove board player simulations chunkSize) moves
    in (fst (maximumBy (on compare snd) winCounts))