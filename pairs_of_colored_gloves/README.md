# Puzzle Statement
There are 20 gloves in a drawer: 5 pairs of black, 3 pairs of brown, 2 pairs of gray. You select the gloves in the dark
and then inspect them later. What is the smallest number of gloves you need to select to guarantee the following:
a) at least one matching pair, b) at least one matching pair of each color.

# Solution Strategy
Basically the question is what is the unluckiest you can get when randomly selecting gloves from a bag. It is easy
to reason logically and get to an answer but it is also just as easy to enumerate all the possible selections you can make
and then partition them into groups and select a maximal element satisfying a certain criterion. 

We can represent the drawer as a multiset: `{black:(5,5), brown:(3,3), gray:(2,2)}`. The notation `black:(5,5)` means a set that contains
5 left gloves and 5 right gloves each of which is black. Similarly for the other colors. Now we just need a convenient
way to enumerate all subsets of the above multiset but that's easy to do as well because we can represent subsets of `black:(5,5)`
using the same notation. The subsets are just pairs of integers in each position starting at 0 and ending at 5, e.g.
`black:(0,0)`, `black:(1,0)`, `black:(2,0)`, ..., `black:(5,0)`, `black:(5,1)`, ..., `black:(5,5)`. The set of all subsets
then just ends up being all possible combinations of such subsets of black gloves paired with brown gloves paired with
gray gloves.

Once we have the above mentioned subsets we can partition them and look for maximal subsets in each partition. The partition
function is pretty simple and is meant to measure the number of pairs in each set modulo color. What that means is that the
subsets `{black:(5,2), gray:(2,2)}` and `{brown:(3,3), black:(5,5)}` are both mapped to the number 2 and so end up in the same
partition even though the second set has "more" pairs of gloves. Now the way we measure size of the subset is less tricky and
is simply the number of elements. So using the previous example, the set `{black:(5,2), gray:(2,2)}` is smaller than
`{brown:(3,3), black:(5,5)}`.

So with the above prerequisites we have pretty simple descriptions of solutions for both a) and b). The solution to a)
is the number of elements for a maximal set in the partition where there are "0 pairs" and the solution to b) is the number of elements
of a maximal set in the partition with "2 pairs".
