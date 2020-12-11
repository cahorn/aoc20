import collections
import functools
import itertools
import re
import sys

BoardingPass = collections.namedtuple("BoardingPass", ["row", "col", "sid"])

def binToDec(zero, one, text):
    """Parse a binary number with the given character 'digits' from text."""
    def acc(a, b):
        if b not in [zero, one]:
            raise TypeError(f"invalid didgit: {b}")
        return 2 * a + (0 if b == zero else 1)
    return functools.reduce(acc, text, 0)

def boardingPass(text):
    """
    Parse a boarding pass from a line of text.

    Observe that the binary space partitioning algorithm described in the
    question is actually isomorphic to a simple binary number conversion. Take
    the first example (FBFBBFFRLR):
        FBFBBFF -> 0101100 base 2 -> 44 base 10
        RLR     -> 101     base 2 -> 5  base 10

    Uses a regex in lieu of a full parsing grammar.
    """
    match = re.match("^([FB]{7})([LR]{3})$", text)
    row = binToDec("F", "B", match[1])
    col = binToDec("L", "R", match[2])
    return BoardingPass(row, col, row * 8 + col)

def ids(text):
    """Parse a sorted list of boarding pass seat ids from text."""
    return sorted(map(lambda t: boardingPass(t).sid, text.splitlines()))

def part1(text):
    """Get the solution to part 1."""
    return ids(text)[-1]

def part2(text):
    """Get the solution to part 2."""
    seats = ids(text)
    return next(itertools.dropwhile(lambda t: t[0] == t[1],
                                    zip(itertools.count(seats[0]), seats)))[0]

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} PART", file=sys.stderr)
    elif int(sys.argv[1]) == 1:
        print(part1(sys.stdin.read()))
    elif int(sys.argv[1]) == 2:
        print(part2(sys.stdin.read()))
    else:
        print(f"Error: unknown part: {sys.argv[1]}", file=sys.stderr)
