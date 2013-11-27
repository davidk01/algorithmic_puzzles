# Puzzle Statement
Find all values of `n > 1` for which one can dissect a rectangle into n right triangles and outline an algorithm for doing such a dissection

# Solution Strategy
We are going to start with the algorithm and work our way to the numbers. Suppose we have a rectangle that is not a square, i.e. its width does
not equal its height, and lets think about what we can do to it. The most obvious thing we can do is cut the rectangle diagonally to get `2` right
triangles. The slightly less obvious thing we can do is cut the rectangle into `k` parts and then cut those diagonally to get `2k` right triangles.
We're still not done yet. Remember that we are assuming that `w <> h` which means we can cut the triangle in such a way as to get a square and a left
over rectangle. The square is interesting because now we can split it into `2`, `3`, or `4` right triangles. Not only that but we can continue to split
the square into `4` equal parts and then turn each of those pieces into `2`, `3` or `4` right triangles.

We are going to encode all of the above operations as a set of rewrite rules. We will represent a rectangle that is not a square with `R`, a sqaure
with `S`, and a right triangle with `T`. The rewrite rules will be `R -> RR | SR | TT`, `S -> SSSS | TT | TTT | TTTT`. Now a bit more analysis will
reveal which numbers end up being right triangle dissections. So now suppose `n` is even in that case we just take `k = n/2` and apply the rule `R -> RR`
repeatedly `k` times and then apply `R -> TT` to get `2k = 2(n/2) = n` right triangles. This means that every even number is a result of some triangle
dissection. Now suppose the number is not even, e.g. `n = 2k + 1`. If we subtract `3` from `n` then we get `n - 3 = 2k + 1 - 3 = 2k - 2 = 2(k - 1)` which
is an even number so we have reduced it to a case we already know and to deal with `3` we just need to apply the rule `R -> SR` once to get a square that
we can then dissect into `3` right triangles. This leaves us with `R` which we can proceed with as in the previous case for an even number.
