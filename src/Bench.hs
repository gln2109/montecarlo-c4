module Main where

import Board
import EvalSeq
import EvalPar
import EvalChunk
import Control.Monad (forM_, forM)
import System.CPUTime
import Data.Time.Clock
import Control.Exception (evaluate)
import Control.DeepSeq (force, deepseq)

testBoards :: [(Board, Player)]
testBoards = [(applyMoveList emptyBoard Red [3,3,2,4,1,4], Red),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,2], Blue),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4], Red),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4,4,0,1], Blue),
              (applyMoveList emptyBoard Red [3,0,2,4,1,4,3,4,4,0,1,2], Red)]

main :: IO ()
main = do
    putStrLn "Test Boards:\n"
    forM_ testBoards (\(board, player) -> do putStrLn (boardString board ++ "Player: " ++ (show player) ++ "\n"))
    let sims = 5000

--    start1 <- getCurrentTime
--    forM_ testBoards (\(board, player) -> do evaluate (bestMoveSeq board player sims))
--    end1 <- getCurrentTime
--    putStrLn ("Sequential Time: " ++ show (diffUTCTime end1 start1))

    start2 <- getCurrentTime
    forM_ testBoards (\(board, player) -> do evaluate (bestMovePar board player sims))
    end2 <- getCurrentTime
    putStrLn ("Basic Parallel Time: " ++ show (diffUTCTime end2 start2))

    start3 <- getCurrentTime
    forM_ testBoards (\(board, player) -> do evaluate (bestMoveChunk board player sims 625))
    end3 <- getCurrentTime
    putStrLn ("Chunked Parallel Time: " ++ show (diffUTCTime end3 start3))

    start4 <- getCurrentTime
    forM_ testBoards (\(board, player) -> do evaluate (bestMoveChunk board player sims 10))
    end4 <- getCurrentTime
    putStrLn ("Time: " ++ show (diffUTCTime end4 start4))

