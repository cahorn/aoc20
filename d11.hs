import Data.Array
import Data.Ix

import AoC20Lib

line a (r, c) (dr, dc) = let l = iterate (\(a, b) -> (a+dr, b+dc)) (r, c)
                         in tail . map (a!) $ takeWhile (inRange $ bounds a) l

cardLines a p = map (line a p) ds
    where ds = [(i, j) | i <- [(-1)..1], j <- [(-1)..1], i /= 0 || j /= 0]

adjacent a = occurences '#' . map head . filter (/=[]) . cardLines a

sight a = occurences '#' . first . cardLines a
    where first = map head . filter (/=[]) . map (dropWhile (=='.'))

rule m 'L' os = if os == 0 then '#' else 'L'
rule m '#' os = if os < m then '#' else 'L'
rule _ s   _  = s

next occ rule a = accum rule a $ zip (indices a) (map (occ a) (indices a))

fixpoint f initial = let fs = iterate f initial
                     in fst . head . dropWhile (uncurry (/=)) $ zip fs (tail fs)

solution f = occurences '#' . elems . fixpoint f . gridFromList . lines

part1 = solution $ next adjacent (rule 4)

part2 = solution $ next sight (rule 5) 

#include "main.hs"
