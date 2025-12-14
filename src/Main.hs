module Main where

import Board

main :: IO ()
main = do
    let testBoard = applyMoveList emptyBoard Red [3,3,2,4,2,4,1]

    putStrLn (boardString testBoard)
    putStrLn (show (checkWin testBoard))
    putStrLn (show (availableMoves testBoard))

    let newBoard = applyMoveList testBoard Blue [3,0,3,3,3]
    putStrLn (boardString newBoard)
    putStrLn (show (checkWin newBoard))
    putStrLn (show (availableMoves newBoard))