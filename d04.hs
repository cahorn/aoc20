import Data.Either
import Data.Ix
import qualified Data.Set as Set
import Control.Monad
import Text.Parsec
import Text.Parsec.String

import AoC20Lib

tryParse :: Parser a -> String -> Bool
tryParse p = isRight . parse p ""

type Field = (String, Value)
data Value = Str String | Num Int | Unit Int String

key = count 3 letter

genericField = do {k <- key; char ':'; v <- word; return (k, Str v)}

year = count 4 digit >>= return . read

val "byr" = do {y <- year; guard $ inRange (1920, 2002) y; return $ Num y}
val "iyr" = do {y <- year; guard $ inRange (2010, 2020) y; return $ Num y}
val "eyr" = do {y <- year; guard $ inRange (2020, 2030) y; return $ Num y}
val "hgt" = do
    h <- number
    u <- string "cm" <|> string "in"
    guard $ if u == "cm" then inRange(150, 193) h else inRange(59, 76) h
    return $ Unit h u
val "hcl" = char '#' >> count 6 (oneOf "0123456789abcdef") >>= return . Str
val "ecl" = let colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
            in do {c <- word; guard $ elem c colors; return $ Str c}
val "pid" = count 9 digit >>= return . Num . read
val "cid" = word >>= return . Str

strictField = do {k <- key; char ':'; v <- val k; return (k, v)}

passport :: Parser Field -> Parser [Field]
passport f = do
    fs <- sepEndBy1 f space
    let require = Set.fromList ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    guard . Set.isSubsetOf require . Set.fromList . map fst $ fs
    return fs


part1 = length . filter (tryParse $ passport genericField) . blocks

part2 = length . filter (tryParse $ passport strictField) . blocks

#include "main.hs"
