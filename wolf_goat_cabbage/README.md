# Puzzle Statement
A man wants to a get a wolf, a goat, and a head of cabbage
from one side of the river to the other on a boat. The wrinkle
is that in his absence the wolf will eat the goat and the goat
will eat the cabbage. Show that it is possible to get all 3 from
one side to the other.

# Solution Strategy
Start with a seed game state and continue expanding and pruning newly generated
states until we find a state that satisifes the solution criteria for the
puzzle. We are in the end interested in the sequences of moves that will get
us from the seed state to the final state so we keep track of the moves that
generate new states from old ones.
