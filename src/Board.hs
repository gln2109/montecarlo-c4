{-# LANGUAGE DeriveGeneric #-}
module Board where

import Data.Maybe
import GHC.Generics (Generic)
import Control.DeepSeq

data Player = Red | Blue deriving (Eq, Show, Generic)
instance NFData Player

type Cell = Maybe Player
type Board = [[Cell]]

boardRows, boardCols :: Int
boardRows = 6
boardCols = 7

otherPlayer :: Player -> Player
otherPlayer Red = Blue
otherPlayer Blue = Red

 -- generate empty board
emptyBoard :: Board
emptyBoard = replicate boardRows (replicate boardCols Nothing)

 -- return array of open cols
availableMoves :: Board -> [Int]
availableMoves board = [col | col <- [0..boardCols-1], isNothing (board !! 0 !! col)]

-- return new Board with move applied
applyMove :: Board -> Player -> Int -> Board
applyMove board player col =
    case [row | row <- [0..boardRows-1], isNothing (board !! row !! col)] of
        []        -> board
        emptyRows -> let row = maximum emptyRows
                         newRow = take col (board !! row) ++ [Just player] ++ drop (col+1) (board !! row)
                     in take row board ++ [newRow] ++ drop (row+1) board

-- recursively apply an array of moves, alternating players
applyMoveList :: Board -> Player -> [Int] -> Board
applyMoveList board _ [] = board
applyMoveList board player (col:cols) = applyMoveList (applyMove board player col) (otherPlayer player) cols

-- return a string representation of the board
boardString :: Board -> String
boardString board =
    unlines [
        concat [playerChar (board !! row !! col) ++ " " | col <- [0..boardCols-1]]
        | row <- [0..boardRows-1]
    ]
    where
        playerChar Nothing = "."
        playerChar (Just Red) = "R"
        playerChar (Just Blue) = "B"

-- return a winning player if one exists
checkWin :: Board -> Maybe Player
checkWin board = checkCells [(row,col) | row <- [0..boardRows-1], col <- [0..boardCols-1]]
    where
        checkFour row col drow dcol =
            let lastRow = row + 3*drow
                lastCol = col + 3*dcol
            in if lastRow < 0 || lastRow > boardRows-1 || lastCol< 0 || lastCol > boardCols-1 then Nothing
            else case board !! row !! col of
                 Nothing     -> Nothing
                 Just player ->
                    let otherCells = [(board !! (row + d*drow) !! (col + d*dcol)) | d <-[1..3]]
                    in if all (== Just player) otherCells then Just player else Nothing

        checkDirs :: (Int,Int) -> [(Int,Int)] -> Maybe Player
        checkDirs _ [] = Nothing
        checkDirs cell (dir:dirs) =
            case checkFour (fst cell) (snd cell) (fst dir) (snd dir) of
                Nothing     -> checkDirs cell dirs
                Just player -> Just player

        checkCells :: [(Int, Int)] -> Maybe Player
        checkCells [] = Nothing
        checkCells (cell:cells) =
            case checkDirs cell [(1,0),(0,1),(1,1),(1,-1)] of
                Nothing     -> checkCells cells
                Just player -> Just player
