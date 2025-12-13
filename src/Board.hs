module Board where


import Data.Maybe

data Player = Red | Blue deriving (Eq, Show)
type Cell = Maybe Player
type Board = [[Cell]]

boardSize :: (Int, Int) -- rows, cols
boardSize = (6,7)

emptyBoard :: Board
emptyBoard = replicate (fst boardSize) (replicate (snd boardSize) Nothing)


availableMoves :: Board -> [Int]
availableMoves board = [col | col <- [0..(snd boardSize)-1], isNothing (board !! 0 !! col)]

applyMove :: Board -> Player -> Int -> Board
applyMove board player col =
    case [row | row <- [0..(fst boardSize)-1], isNothing (board !! row !! col)] of
        []        -> board
        emptyRows -> let row = maximum emptyRows
                         newRow = take col (board !! row) ++ [Just player] ++ drop (col+1) (board !! row)
                     in take row board ++ [newRow] ++ drop (row+1) board


--checkWin :: Board -> Maybe Player
--checkWin board =



boardString :: Board -> String
boardString board = unlines [concat [playerChar (board !! row !! col) ++ " " | col <- [0..(snd boardSize)-1]] | row <- [0..(fst boardSize)-1]] ++ "0 1 2 3 4 5 6"
    where
        playerChar Nothing = "."
        playerChar (Just Red) = "R"
        playerChar (Just Blue) = "B"


applyMoveList :: Board -> Player -> [Int] -> Board
applyMoveList board _ [] = board
applyMoveList board player (col:cols) = applyMoveList (applyMove board player col) (otherPlayer player) cols
    where
        otherPlayer Red = Blue
        otherPlayer Blue = Red


testBoard :: (Board, Player)
testBoard = (applyMoveList emptyBoard Red [3,3,2,4,2,4,1], Red)

