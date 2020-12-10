import Control.Applicative
import Data.List

import AoC20Lib

differences l = zipWith subtract l (tail l)

arrangements as = arrs
    where arrs = zipWith4 acc mask (1:arrs) (0:0:arrs) (0:0:0:arrs)
          acc b x y z = b * (sum [x, y, z])
          mask = [if elem i as then 1 else 0 | i <- [0..maximum as]]

adapters = (\as -> 0 : as ++ [maximum as + 3]) . sort . map read . lines

part1 = product . (occurences <$> [1, 3] <*>) . pure . differences . adapters

part2 = last . arrangements . adapters

#include "main.hs"
