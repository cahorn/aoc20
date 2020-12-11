import Control.Applicative
import Data.Array

import AoC20Lib

slope (dr, dc) a = map (a!) $ zip [0,dr..mr] [mod c (mc+1) | c <- [0,dc..]]
    where (mr, mc) = snd (bounds a)

part1 = occurrences '#' . slope (1, 3) . gridFromList . lines

part2 = product . map (occurrences '#') . slopes . gridFromList . lines
    where slopes = liftA2 slope [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)] . pure

#include "main.hs"
