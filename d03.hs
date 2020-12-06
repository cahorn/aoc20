import Control.Applicative
import Data.Array

import AoC20Lib

gridFromList :: [[a]] -> Array (Int, Int) a
gridFromList l = array bounds elements
    where bounds   = ((0, 0), (length l - 1, length (head l) - 1))
          elements = do
               (i, r) <- zip [0..] l
               (j, e) <- zip [0..] r
               return ((i, j), e)

slope (dr, dc) a = map (a!) $ zip [0,dr..mr] [mod c (mc+1) | c <- [0,dc..]]
    where (mr, mc) = snd (bounds a)

part1 = occurences '#' . slope (1, 3) . gridFromList . lines

part2 = product . map (occurences '#') . slopes . gridFromList . lines
    where slopes = liftA2 slope [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)] . pure

#include "main.hs"
