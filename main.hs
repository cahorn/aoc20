#ifndef PART2
main = getContents >>= print . part1
#else
main = getContents >>= print . part2
#endif
