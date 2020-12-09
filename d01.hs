import AoC20Lib

solution n = product . head . sumTo 2020 . (!!n) . cartesians

part1 = solution 2 . map read . lines

part2 = solution 3 . map read . lines

#include "main.hs"
