# Puzzle Statement
Is there a way for the knight to start on the lower left corner of a standard 8x8 chess board
and then end at the top right corner while visiting all the other positions on the board
exactly once?

# Solution Strategy
There is a simple invariant that will give the answer. Every time the knight moves the color
of the square it ends up on flips. There are 64 positions on the board, the lower left is black and
the upper right is black. From the starting position the night will have to make 63 moves exactly
to get to the upper right corner. 63 moves means that the final color the knight lands on will be
white but the uppper right corner is black so such a tour is impossible.

The algorithmic solution is to just enumerate all possible state expansions starting at the lower
left corner and then show that we end up with the empty set. This strategy turns out to be
unfeasible because of what's known us the open knight tour problem and this puzzle is an instance
of such a problem. See http://en.wikipedia.org/wiki/Knight%27s_tour.
