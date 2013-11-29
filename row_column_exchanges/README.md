# Puzzle Statement
Can one transform the table on top to the table on the bottom by applying a sequence of row and column operations?

| 1      | 2      | 3      | 4       |
| ------ | ------ | ------ | ------: |
| 5      | 6      | 7      | 8       |
| 9      | 10     | 11     | 12      |
| 13     | 14     | 15     | 16      |


| 12     | 10     | 11     | 9       |
| ------ | ------ | ------ | ------: |
| 16     | 14     | 5      | 13      |
| 8      | 6      | 7      | 15      |
| 4      | 2      | 3      | 1       |

# Solution Strategy
We are going to use some very basic group theory to solve this one. All we need are some basic facts about permutations groups, group actions,
and orbits. This puzzle is really just asking whether the second table is in the orbit of the first table under the action of the group of permutations
of rows and columns. So starting with the set that just contains the first table we are just going to act on it with the group until we can not get any more
new elements. At that point we'll know that we have the entire orbit and we can check to see if the second table is in the orbit.
