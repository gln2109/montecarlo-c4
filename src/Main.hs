module Main where

import Board
import EvalSeq

main :: IO ()
main = do
    let testBoard = applyMoveList emptyBoard Red [3,3,2,4,1,4]

    putStrLn (boardString testBoard)

    let bestMove = bestMoveSeq testBoard Red 5000
    putStrLn (show bestMove)

    let newBoard = applyMoveList testBoard Red [1,0,2,3]
    putStrLn (boardString newBoard)

    let newBestMove = bestMoveSeq newBoard Red 10000
    putStrLn (show newBestMove)