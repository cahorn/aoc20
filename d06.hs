import qualified Data.Set as Set

import AoC20Lib

answers = map Set.fromList . lines

part1 = sum . map (Set.size . Set.unions . answers) . blocks

part2 = sum . map (Set.size . foldl1 Set.intersection . answers) . blocks

#include "main.hs"
