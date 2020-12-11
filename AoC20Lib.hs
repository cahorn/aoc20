module AoC20Lib where

import Data.Array
import Data.Char
import Text.Parsec
import Text.Parsec.String

cartesians l = iterate (>>= \p -> map (:p) l) [[]]

occurrences x = length . filter (==x)

sumTo n = filter ((==n) . sum)

blocks = let block = many1 $ notFollowedBy (count 2 newline) >> anyChar
         in simpleParse $ sepEndBy block (newline >> many1 newline)

gridFromList :: [[a]] -> Array (Int, Int) a
gridFromList l = array bounds elements
    where bounds   = ((0, 0), (length l - 1, length (head l) - 1))
          elements = do
               (i, r) <- zip [0..] l
               (j, e) <- zip [0..] r
               return ((i, j), e)

number :: Parser Int
number = do
    s <- option '+' (oneOf "+-")
    n <- many1 digit >>= return . read
    return $ if s == '+' then n else negate n

word :: Parser String
word = many1 $ satisfy (not . isSpace)

simpleParse :: Parser a -> String -> a
simpleParse p s = case parse p "" s of {Left e -> error $ show e; Right r -> r}
