import sys

def occurrences(x, lst):
    """Count the number of occurrences of x in lst."""
    return len(list(filter(lambda e: x == e, lst)))

def differences(lst):
    """Calculate differences between consecutive elements of a list."""
    return (b - a for (a, b) in zip(lst, lst[1:]))

def arrangements(adapters):
    """
    Generate a list whose elements [e_0, e_1, ... e_i] are the number of
    distinct ways the given adapters can be arranged to provide exactly i jolts.

    Observing that:
        1. There's only one wall outlet:
            e_0 = 1
        2. How are you going to get i jolts without an i-jolt adapter?
            e_i = 0 - if i not in adapters
        3. Each adapter can plug into any every possible arrangement of adapters
           providing i-1, i-2, and i-3 jolts:
            e_i = e_i-1 + e_i-2 + e_i-3 - if i in adapters
    A solution can be computed efficiently with textbook bottom-up dynamic
    programming: https://en.wikipedia.org/wiki/Dynamic_programming#Computer_programming

    Sadly, as Python does not have support for recursive list definitions,
    one-lining the solution as a zip with an accumulator function and a bitmask
    (à la d10.hs:9) is not possible. :'(
    """
    mask = [1 if i in adapters else 0 for i in range(max(adapters) + 1)]
    res = [1]
    for i in range(1, len(mask)):
        res.append(mask[i] * sum(res[i-j] for j in range(1, 4) if i-j >= 0))
    return res

def adapters(text):
    """
    Parse lines of text into a list of adapters (represented by their joltage),
    supplemented by the outlet (0) and your device (maximum + 3).
    """
    adapters = list(sorted(map(int, text.splitlines())))
    adapters = [0] + adapters + [max(adapters) + 3]
    return adapters

def part1(text):
    """Get the solution to part 1."""
    diffs = list(differences(adapters(text)))
    return occurrences(1, diffs) * occurrences(3, diffs)

def part2(text):
    """Get the solution to part 2."""
    return arrangements(adapters(text))[-1]

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} PART", file=sys.stderr)
    elif int(sys.argv[1]) == 1:
        print(part1(sys.stdin.read()))
    elif int(sys.argv[1]) == 2:
        print(part2(sys.stdin.read()))
    else:
        print(f"Error: unknown part: {sys.argv[1]}", file=sys.stderr)
