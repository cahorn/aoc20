module AoC20Lib where

import Data.Char
import Text.Parsec
import Text.Parsec.String

occurences x = length . filter (==x)

blocks = let block = many1 $ notFollowedBy (count 2 newline) >> anyChar
         in simpleParse $ sepEndBy block (newline >> many1 newline)

number :: Parser Int
number = many1 digit >>= return . read

word :: Parser String
word = many1 $ satisfy (not . isSpace)

simpleParse :: Parser a -> String -> a
simpleParse p s = case parse p "" s of {Left e -> error $ show e; Right r -> r}
