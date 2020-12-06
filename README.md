Advent of Code 2020
===================

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
