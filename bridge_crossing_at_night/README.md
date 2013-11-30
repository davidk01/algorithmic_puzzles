# Puzzle Statement
Four people need to cross a rickety footbridge at night. It's very dark but they have a flashlight with them. Only two people can cross at a time and one of them
must carry the flashlight. When crossing they can only move at the pace of the slowest person. Person 1 takes 1 minute to cross the bridge, person 2 takes 2 minutes,
person 3 takes 5 minutes and person 4 takes 10 minutes. Can they cross the bridge in 17 minutes?

# Solution Strategy
We are going to reprsent the state of the game by who's on each side and our representation is going to be the number of minutes it takes each person to cross, e.g.
`left:[1,2,5,10], right:[]` represents the initial state of the game because everyone is on one side of the bridge. We also need to keep track of where the flashlight
is so our data structure will also keep track of that. So if the flashlight is on the left then out of all the people that are on the left side we pick all possible
pairs explore what happens if those pairs cross the bridge in parallel. Similarly if the flashlight is on the right then we pick every single person that can carry
it back and exlore the possibilities of that move in parallel. We continue this parallel exploration until everyone is on the right and then we calculate the total
time it took to get to the right. If one of those sequence of moves has total cost less than or equal to 17 minutes then we know that it is possible to cross from
one side to the other in that amount of time.
