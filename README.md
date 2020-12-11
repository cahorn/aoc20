Advent of Code 2020
===================

See: [adventofcode.com](https://adventofcode.com/)

Dependencies
------------

* The [Glorious Haskell Compiler](https://www.haskell.org/ghc/)

Build
-----

Compile everything:

    $ make

Compile a specific solution:

    $ make d01p1

Clear build artifacts:

    $ make clean

Use
---

Solutions are built into executables that (in good UNIX form) act as filters;
they accept input from standard input and provide (terse) responses on standard
output.

Example:

    $ ./d01p1 < d01.txt
    997899

B-b-b-bonus!
-------------------

Python 3 transliterations are written as close to idiomatic functional style as
possible within the constraints of the Python language. Warning: do not write in
this style in production environments - your fellow Python coders will not
appreciate your antics ;)

Use example:

    $ python d05.py 2 < d05.txt
    640
