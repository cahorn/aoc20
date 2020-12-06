cartesians l = iterate (>>= \p -> map (:p) l) [[]]

solution n = product . head . filter ((==2020) . sum) . (!!n) . cartesians

part1 = solution 2 . map read . lines

part2 = solution 3 . map read . lines

#include "main.hs"
