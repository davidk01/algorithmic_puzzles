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

##
# Expand the seed set with the permutations of the rows and columns
# until we reach a fixed point.

def expander(seed)
  old_seed_size = seed.size
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
  if seed.size == old_seed_size
    seed
  else
    expander(seed)
  end
end

fixed_point = expander(Set.new([first_table]))
fixed_point_size = fixed_point.size
if fixed_point_size == (fixed_point << second_table).size
  puts "Second table is in the orbit."
else
  puts "Second table is not in the orbit."
end
