# Puzzle Statement
Is it possible to tile an 8x8 board with dominos (2x1) such that no two dominos form a square?

# Solution Strategy
We are going to enumerate all possible tilings by locally expanding partially filled boards while
maintaing "no square" invariant. If at the end of the process we can fill the board then a solution
exists. If we hit a brick wall while trying to enforce the invariant then no solution exists. We will
follow a very simple strategy for expanding a partially filled board. Find the first non-filled
square and fill it with dominos while still satisfying the constraint. It is easy to show that
this strategy will find a solution if one exists and give us back the empty set if no solution
exists.
