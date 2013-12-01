# Puzzle Statement
For each of the following cases prove or disprove that for every `n > 0` all the boards of the
following dimension can be tiled by right trominoes. Look up the definition of a right tromino
if you don't know what it is. It's basically the L shape in tetris. The board dimensions are:
a) `3^n x 3^n`, b) `5^n x 5^n`, c) `6^n x 6^n`.

# Solution Strategy
We need some invariants to rule out various board sizes. After playing around with a `3 x 3` board
you will probably notice that every time you lay down a tromino you reduce the count of empty
cells on the board by `3`. This means we need the number of cells to be a multiple of `3`.
This already rules out case b) `5^n x 5^n`. Moreover, the smallest instance of `3^n x 3^n`, `3 x 3`,
does not have a solution. You can conclude this by analyzing the possibilities for one of the corners. So this rules out a) as well because the puzzle statement is "for every `n > 0`".
A `6 x 6` board is solvable by laying down trominoes in such a way
as to make `3 x 2` tiles. So by simple induction we can solve any board of size `6^n x 6^n`
by splitting up the board into `6 x 6` blocks and solving each one.

I'm not sure how or why `3^n x 3^n` has a solution for all `n > 1`.
