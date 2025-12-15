module EvalSeq (bestMoveSeq) where

import Board
import System.Random
import Data.Function (on)
import Data.List

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

-- count simulation wins for each move
evalMove :: Board -> Player -> Int -> Int -> (Int, Int)
evalMove board player simulations move =
    let gens = [mkStdGen s | s <- [1..simulations]]
        newBoard = applyMove board player move
        results = map (simulate newBoard (otherPlayer player)) gens
    in (move, length (filter (== Just player) results))

-- return the move with the most wins
bestMoveSeq :: Board -> Player -> Int -> Int
bestMoveSeq board player simulations =
    let moves = availableMoves board
        winCounts = map (evalMove board player simulations) moves
    in (fst (maximumBy (on compare snd) winCounts))