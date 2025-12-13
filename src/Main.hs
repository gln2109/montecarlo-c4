module Main where

import Board

main :: IO ()
main = do
    putStrLn (boardString (fst testBoard))
    --putStrLn (availableMoves testBoard)