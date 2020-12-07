import Data.List
import Text.Parsec

import AoC20Lib

binToDec z o = let acc a b | b == z = 2*a + 0 | b == o = 2*a + 1 in foldl acc 0

data BoardingPass = BoardingPass {row::Int, col::Int, sid::Int}

boardingPass = do
    r <- count 7 (oneOf "FB") >>= return . binToDec 'F' 'B'
    c <- count 3 (oneOf "LR") >>= return . binToDec 'L' 'R'
    return $ BoardingPass r c (r * 8 + c)

ids = sort . map (sid . simpleParse boardingPass) . lines

part1 = last . ids

part2 s = fst . head . dropWhile (uncurry (==)) $ zip ([head (ids s)..]) (ids s)

#include "main.hs"
