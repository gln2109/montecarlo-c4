module Main where

import Board
import EvalPar
import Text.Read (readMaybe)

getMove :: Board -> IO Int
getMove board = do
    putStrLn "Enter move (1-7):"
    move <- getLine
    case readMaybe move :: Maybe Int of
        Just num -> do
            if notElem (num-1) (availableMoves board) then do
                putStrLn "Invalid move."
                getMove board
            else return num
        Nothing -> do
            putStrLn "Invalid move."
            getMove board

playGame :: Board -> Player -> IO ()
playGame board player = do
    putStrLn ("\n" ++ show player ++ "'s turn:")
    putStrLn "1 2 3 4 5 6 7"
    putStrLn (boardString board)
    case checkWin board of
        Just winner -> putStrLn (show winner ++ " wins!")
        Nothing ->
            if (availableMoves board) == [] then putStrLn "Draw."
            else do
                if player == Red then do
                    playerMove <- getMove board
                    let playerBoard = applyMove board Red (playerMove-1)
                    playGame playerBoard Yellow
                else do
                    let evalMove = bestMovePar board Yellow 2048
                        evalBoard = applyMove board Yellow evalMove
                    putStrLn ("Yellow move: " ++ (show (evalMove+1)))
                    playGame evalBoard Red

main :: IO ()
main = do
    playGame emptyBoard Red