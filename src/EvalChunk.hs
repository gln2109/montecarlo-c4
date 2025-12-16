module EvalChunk (bestMoveChunk) where

import Board
import System.Random
import Data.Function (on)
import Data.List
import Control.Parallel.Strategies

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
bestMoveChunk :: Board -> Player -> Int -> Int -> Int
bestMoveChunk board player simulations chunkSize =
    let moves = availableMoves board
        winCounts = map (evalMove board player simulations chunkSize) moves
    in (fst (maximumBy (on compare snd) winCounts))