module Main where

import Board
import EvalSeq
import EvalPar
import EvalChunk
import Control.Monad (forM)
import Data.Time.Clock

testBoards :: [(Board, Player)]
testBoards = [(applyMoveList emptyBoard Red [3,3,2,4,1,4], Red),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,2], Blue),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4], Red),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4,4,0,1], Blue),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4,4,0,1,2], Red)]

main :: IO ()
main = do
    putStrLn "Test Boards:\n"
    _ <- forM testBoards (\(board, player) -> do putStrLn (boardString board ++ "Player: " ++ (show player) ++ "\n"))
    let sims = 5000

    putStrLn "Sequential"
    start1 <- getCurrentTime
    moves1 <- forM testBoards (\(board, player) -> return (bestMoveSeq board player sims))
    putStrLn ("Moves: " ++ show moves1)
    end1 <- getCurrentTime
    putStrLn ("Time: " ++ show (diffUTCTime end1 start1))

    putStrLn "\nBasic Parallel"
    start2 <- getCurrentTime
    moves2 <- forM testBoards (\(board, player) -> return (bestMovePar board player sims))
    putStrLn ("Moves: " ++ show moves2)
    end2 <- getCurrentTime
    putStrLn ("Time: " ++ show (diffUTCTime end2 start2))

    putStrLn "\nChunked Parallel"
    start3 <- getCurrentTime
    moves3 <- forM testBoards (\(board, player) -> return (bestMoveChunk board player sims 625))
    putStrLn ("Moves: " ++ show moves3)
    end3 <- getCurrentTime
    putStrLn ("Time: " ++ show (diffUTCTime end3 start3))

    putStrLn "\nChunked Parallel"
    start4 <- getCurrentTime
    moves4 <- forM testBoards (\(board, player) -> return (bestMoveChunk board player sims 10))
    putStrLn ("Moves: " ++ show moves4)
    end4 <- getCurrentTime
    putStrLn ("Time: " ++ show (diffUTCTime end4 start4))
