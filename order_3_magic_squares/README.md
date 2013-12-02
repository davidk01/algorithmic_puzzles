# Puzzle Statement
A magic square of order 3 is a 3x3 square filled with 9 distinct integers from 1 to 9 such
that all row, column, and diagonal sums are all the same number. Find all magic squares of
order 3.

# Solution Strategy
Graph unfolding with constraint propagation. It would also be just as easy to solve
the problem by brute force searching through all possible permutations of `(1..9)`
by filtering out anything that does not satisfy the constraints.
