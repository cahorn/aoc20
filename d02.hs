import Data.Char
import Data.Ix
import Text.Parsec
import Text.Parsec.String

data Password = Password Int Int Char String

number = many1 digit >>= return . read

word = many1 $ satisfy (not . isSpace)

password = do
    l <- number
    char '-'
    h <- number
    space
    c <- anyChar
    char ':' >> space
    s <- word
    return (Password l h c s)

simpleParse :: Parser a -> String -> a
simpleParse p s = case parse p "" s of {Left e -> error $ show e; Right r -> r}

occurences x = length . filter (==x)

solution v = length . filter v . map (simpleParse password)

part1 = solution validator . lines
    where validator (Password l h c s) = inRange (l, h) $ occurences c s

part2 = solution validator . lines
    where validator (Password l h c s) = (s !! (l-1) == c) /= (s !! (h-1) == c)

#include "main.hs"
