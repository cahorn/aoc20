import Control.Arrow
import Text.Parsec

import AoC20Lib

buses = let bus = (char 'x' >> return 1) <|> number in sepBy bus (char ',')

input = do {t <- number; space; bs <- buses; return (t, bs)}

findBus (t, bs) = minimum [[b - mod t b, b] | b <- bs]

findChain bs = foldl acc (0, fst (head bs')) (tail bs')
    where bs' = filter ((/=1) . fst) $ zip bs [0..]
          acc (t, i) (b, o) = (n, lcm i b)
              where n = head $ dropWhile (\t' -> mod (t'+o) b /= 0) [t, t+i..]

part1 = product . findBus . second (filter (/=1)) . simpleParse input

part2 = fst . findChain . snd . simpleParse input

#include "main.hs"
