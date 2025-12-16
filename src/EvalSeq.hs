module EvalSeq (bestMoveSeq) where

import Board
import System.Random
import Data.Function (on)
import Data.List

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