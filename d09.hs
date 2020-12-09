import Control.Applicative
import Data.List

import AoC20Lib

filterLen p = filter (p . length)

validate (x:xs) = let different (a:b:[]) = a /= b
                  in (/=[]) . sumTo x . filter different $ cartesians xs !! 2


invalid = let ws = map (take 26) . filterLen (25<) . tails . reverse
          in head . head . filter (not . validate) . ws

part1 = invalid . map read . lines

part2 s = sum $ [minimum, maximum] <*> sumTo inv sets
    where ns   = map read $ lines s
          inv  = invalid ns
          sets = tails ns >>= takeWhile ((<=inv) . sum) . filterLen (1<) . inits

#include "main.hs"
