module Main where

import Board
import EvalPar
import Control.Monad (forM_)
import System.CPUTime

testBoards :: [(Board, Player)]
testBoards = [(applyMoveList emptyBoard Red [3,3,2,4,1,4], Red),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,2], Blue),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4], Red),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4,4,0,1], Blue),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4,4,0,1,2], Red)]

main :: IO ()
main = do
    forM_ testBoards (\(board, player) -> do
        putStrLn (boardString board)
        putStrLn ("Player: " ++ show player)
        let bestMove = bestMovePar board player 5000
        putStrLn ("Column: " ++ show bestMove)
        )
