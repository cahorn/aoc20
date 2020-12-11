import sys

def blocks(text):
    """Split the text into blocks deliminated by a blank line."""
    return text.split("\n\n")

def answers(text):
    """Parse all answers for a group from a block of text."""
    return map(set, text.splitlines())

def part1(text):
    """Get the solution to part 1."""
    return sum(map(lambda b: len(set.union(*answers(b))), blocks(text)))

def part2(text):
    """Get the solution to part 2."""
    return sum(map(lambda b: len(set.intersection(*answers(b))), blocks(text)))

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} PART", file=sys.stderr)
    elif int(sys.argv[1]) == 1:
        print(part1(sys.stdin.read()))
    elif int(sys.argv[1]) == 2:
        print(part2(sys.stdin.read()))
    else:
        print(f"Error: unknown part: {sys.argv[1]}", file=sys.stderr)
