import Control.Monad
import qualified Data.Set as Set
import Text.Parsec

import AoC20Lib

data Instruction = Instruction String Int deriving Eq
data ConsoleState = ConsoleState { stateIp   :: Int
                                 , stateAcc  :: Int
                                 , stateHist :: Set.Set Int
                                 , stateHalt :: Bool
                                 }

instruction = do
    op <- word
    space
    arg <- number
    return $ Instruction op arg

instructions = sepEndBy instruction space

step is s@(ConsoleState ip acc hist halt)
    | halt = s
    | ip < 0 || length is <= ip || Set.member ip hist = s { stateHalt = True }
    | otherwise = case is !! ip of
        Instruction "acc" i -> next { stateAcc = acc+i }
        Instruction "jmp" i -> next { stateIp = ip+i }
        Instruction "nop" _ -> next 
        where next = s { stateIp = ip+1, stateHist = Set.insert ip hist }

run is = let initial = ConsoleState 0 0 Set.empty False
         in head . dropWhile (not . stateHalt) . iterate (step is) $ initial

changed is = do
    idx <- [0..length is - 1]
    let i       = is !! idx
        (h, t)  = splitAt idx is
        altered = case i of
            i@(Instruction "acc" _) -> i
            Instruction "jmp" arg   -> Instruction "nop" arg
            Instruction "nop" arg   -> Instruction "jmp" arg
    guard $ i /= altered
    return $ h ++ altered : tail t

part1 = stateAcc . run . simpleParse instructions

part2 = stateAcc . head . runs . simpleParse instructions
    where runs is = filter ((== length is) . stateIp) . map run $ changed is

#include "main.hs"
