magic_squares = (1..9).to_a.permutation.select do |perm|
  rows = perm.each_slice(3).to_a
  sum = rows[0].reduce(&:+)
  rows.all? {|x| x.reduce(&:+) == sum} &&
   rows[0].zip(*rows[1..-1]).all? {|x| x.reduce(&:+) == sum} &&
   rows.each_with_index.reduce(0) {|m, (r, i)| m + r[i]} == sum &&
   rows.each_with_index.reduce(0) {|m, (r, i)| m + r[2 - i]} == sum
end

puts "Magic squares found: #{magic_squares.length}."
