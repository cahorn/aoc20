import qualified Data.Map as Map
import Text.Parsec

import AoC20Lib

bagName = do {a <- word; space; c <- word; return $ a ++ " " ++ c}

containList = do
    l <- flip sepBy (char ',' >> space) $ do
        n <- number
        space
        b <- bagName
        string " bag" >> optional (char 's')
        return (b, n)
    return $ Map.fromList l

bag = do
    k <- bagName
    string " bags contain "
    let none = string "no other bags" >> return Map.empty
    v <- none <|> containList
    char '.'
    return (k, v)

rules = Map.fromList . map (simpleParse bag) . lines

contains rs b = Map.unionsWith (+) $ (rs Map.! b) : children (rs Map.! b)
    where children = map (\(b, n) -> Map.map (*n) $ contains rs b) . Map.assocs

bags rs = Map.mapWithKey (\b _-> contains rs b) rs

part1 = length . filter (Map.member "shiny gold") . Map.elems . bags . rules

part2 = foldr (+) 0 . (Map.! "shiny gold") . bags . rules

#include "main.hs"
