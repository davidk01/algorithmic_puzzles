##
# We keep track of the game state and keep expanding it according to the rules of the game
# until we reach a terminal state. Each new state refers to the state it was expanded from
# along with the cost it took to get to the new state. The cost information will help us
# recursively figure out the total crossing time.

class GameState < Struct.new(:left, :right, :parent, :flashlight, :cost)

  def terminal_state?
    left.empty? && flashlight == :right
  end

  def expand
    if terminal_state?
      raise StandardError, "No expansion possible for terminal states."
    end
    case flashlight
    when :right
      right.map do |mover|
        GameState.new(left + [mover], right.reject {|x| x == mover}, self, :left, mover)
      end
    when :left
      left.combination(2).map do |movers|
        GameState.new(left.reject {|x| movers.include? x}, right + movers, self, :right, movers.max)
      end
    else
      raise StandardError, "Unknown flashlight state. Needs to be :left or :right."
    end
  end

  def state_cost
    parent ? cost + parent.state_cost : cost
  end

  def reverse_move_sequence
    if parent
      "left:[#{left.join(', ')}], right:[#{right.join(', ')}], cost:#{cost}" + "\n" +
       parent.reverse_move_sequence
    else
      "left:[#{left.join(', ')}], right:[#{right.join(', ')}], cost:#{cost}"
    end
  end

end

##
# Recursively expand the states until we reach all terminal states.

def expander(states)
  new_states = states.flat_map do |state|
    if state.terminal_state?
      [state]
    else
      state.expand
    end
  end
  if new_states.length == states.length
    new_states
  else
    expander(new_states)
  end
end

##
# Now just expand the seed state until we reach a fixed point in terms of state expansion 
# and then calculate the cost for each terminal state to figure out what the minimum 
# crossing time will be.

initial_states = [GameState.new([1, 2, 5, 10], [], nil, :left, 0)]
terminal_states = expander(initial_states)
puts "Terminal state count: #{terminal_states.length}."
states_and_times = terminal_states.zip(terminal_states.map {|s| s.state_cost})
states_and_times.sort_by! {|s, cost| cost}
min_moves_time = states_and_times.first
puts "Minimum crossing time: #{min_moves_time[1]} minutes."
puts "Reverse move sequence:"
puts min_moves_time[0].reverse_move_sequence
