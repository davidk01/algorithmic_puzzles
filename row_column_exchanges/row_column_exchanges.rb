require 'set'

first_table = [
 [1, 2, 3, 4],
 [5, 6, 7, 8],
 [9, 10, 11, 12],
 [13, 14, 15, 16]
]

second_table = [
 [12, 10, 11, 9],
 [16, 14, 5, 13],
 [8, 6, 7, 15],
 [4, 2, 3, 1]
]

# now just keep track of the size and continue
# apply permutations to elements in the set until we
# get to a fixed point
seed = Set.new([first_table])
previous_seed_size = -1
current_seed_size = seed.size
while previous_seed_size != current_seed_size
  puts "Expanding seed."
  previous_seed_size = seed.size
  row_column_permutations = seed.map do |matrix|
    row_permutations = matrix.permutation
    # transpose, apply permutations, transpose back
    column_permutations = matrix[0].zip(*matrix[1..-1]).permutation.map {|m| m[0].zip(*m[1..-1])}
    [row_permutations, column_permutations]
  end
  row_column_permutations.each do |row_permutations, column_permutations|
    row_permutations.each {|m| seed << m}
    column_permutations.each {|m| seed << m}
  end
  current_seed_size = seed.size
end

puts "Seed expansion reached fixed point. Checking to see if second table is in the orbit."
seed << second_table
if seed.size == current_seed_size
  puts "Second table is in the orbit."
else
  puts "Second table is not in the orbit."
end
