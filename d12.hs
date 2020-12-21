import Text.Parsec

import AoC20Lib

action = do {a <- oneOf "NSEWLRF"; v <- number; return (a, v)}

manhattan (a, b) (c, d) = abs (a - c) + abs (b - d)

apply1 ((sx, sy), w) ('N', v) = ((sx, sy+v), w)
apply1 ((sx, sy), w) ('S', v) = ((sx, sy-v), w)
apply1 ((sx, sy), w) ('E', v) = ((sx+v, sy), w)
apply1 ((sx, sy), w) ('W', v) = ((sx-v, sy), w)
apply1 state         action   = apply2 state action

apply2 (s, (wx, wy))   ('N', v) = (s, (wx, wy+v))
apply2 (s, (wx, wy))   ('S', v) = (s, (wx, wy-v))
apply2 (s, (wx, wy))   ('E', v) = (s, (wx+v, wy))
apply2 (s, (wx, wy))   ('W', v) = (s, (wx-v, wy))
apply2 (s, w)          ('L', v) = let v' = div (mod v 360) 90
                                  in (s, (iterate (\(x, y) -> (-y, x)) w !! v'))
apply2 (s, w)          ('R', v) = apply2 (s, w) ('L', -v)
apply2 (s, w@(wx, wy)) ('F', v) = (iterate (\(x, y) -> (x+wx, y+wy)) s !! v, w)

actions = map (simpleParse action) . lines

part1 = manhattan (0, 0) . fst . foldl apply1 ((0, 0), (1, 0)) . actions

part2 = manhattan (0, 0) . fst . foldl apply2 ((0, 0), (10, 1)) . actions

#include "main.hs"
