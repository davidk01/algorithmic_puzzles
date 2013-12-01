require 'set'
##
# Note that this brute force approach will not find a solution. 
# See http://en.wikipedia.org/wiki/Knight%27s_tour for various reasons why. We are
# trying to solve the open knight tour problem basically and it is unknown what the 
# number of such tours is even when we restrict ourselves to the constraints in the puzzle.

##
# We represent the state of the game by an array of moves which are just +(x, y)+
# pairs. +(0, 0)+ represents the lower left corner and +(7, 7)+. The way we expand the state
# is pretty simple. We just take the last position and perform the arithmetic operations on
# the pair that correspond to the knight's movement pattern. We throw out everything that is
# out of bounds and any already visited positions. If we end up in the top right corner then
# we keep that position only if we have already visited all other positions otherwise we
# consider than an illegal state and throw it out.

class KnightMoves < Struct.new(:visited_positions, :current_position)

  @@move_offsets = [
   [2, 1], [2, -1], [-2, 1], [-2, -1], # up/(right|left), down/(right|left)
   [1, 2], [-1, 2], [1, -2], [-1, -2], # right/(up|down), left/(up|down)
  ]

  def initialize(visited_positions, current_position)
    super(visited_positions, current_position)
    @history_hash = visited_positions.reduce({}) {|m, pos| m[pos] = true; m}
  end

  ##
  # Are we at +(7, 7)+?

  def at_top_right?
    row, column = current_position
    row == column && row == 7
  end

  ##
  # Have we made +64+ moves counting where we started?

  def visited_all?
    visited_positions.size == 64
  end

  ##
  # Find all potential future positions, filter out places we have already been,
  # generate new states and filter out all the states that end up in the top right
  # corner without having visited all other positions.

  def expand
    row, column = current_position
    potential_positions = @@move_offsets.map do |r_offset, c_offset|
      [row + r_offset, column + c_offset]
    end
    potential_positions.reject! do |row, column|
      @history_hash[pos] || row < 0 || row > 7 || column < 0 || column > 7
    end
    new_states = potential_positions.map {|p| KnightMoves.new(visited_positions + [p], p)}
    new_states.reject {|s| s.at_top_right? && !s.visited_all?}
  end

end

##
# Recursively expand the state until we are left with the empty set or a state that
# satisfies all our criteria for a solution, i.e. last position is top right and all
# other states have been visited.

def expander(seed_states)
  puts "Expanding states."
  new_states = Set.new(seed_states.flat_map {|s| s.expand})
  puts "Current state count: #{new_states.size}."
  if new_states.empty?
    puts "Solution with the given criteria does not exist."
    return
  end
  if (solution = new_states.select {|x| x.visited_all? && x.at_top_right?}.first)
    puts "Solution found."
    require 'pp'
    pp solution.visited_positions
    return
  end
  expander(new_states)
end

seed_state = Set.new([KnightMoves.new(Set.new([[0, 0]]), [0, 0])])
expander(seed_state)
