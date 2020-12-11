import Data.Ix
import Text.Parsec

import AoC20Lib

data Password = Password Int Int Char String

password = do
    l <- number
    char '-'
    h <- number
    space
    c <- anyChar
    char ':' >> space
    s <- word
    return (Password l h c s)

solution v = length . filter v . map (simpleParse password)

part1 = solution validator . lines
    where validator (Password l h c s) = inRange (l, h) $ occurrences c s

part2 = solution validator . lines
    where validator (Password l h c s) = (s !! (l-1) == c) /= (s !! (h-1) == c)

#include "main.hs"
