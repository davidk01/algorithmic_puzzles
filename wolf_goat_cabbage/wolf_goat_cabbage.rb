# To find a solution just fire up IRB and run the following commands
# > explorer = PuzzleStateExplorer.new
# > explorer.explore
# Keep running explore until subsequent invocations no longer return
# new results and then type "explorer.explore.pretty_print_history" to
# get a string representation of the actions.

##
# Convenient representation of an action, i.e. moving from one side
# of the river to the other with potential cargo.

class Move < Struct.new(:cargo)
end

##
# When we apply a left movement to a game state we get a new state
# that takes the cargo from the right river bank if any and moves it
# to the left river bank.

class MoveLeft < Move

  def to_s
    "L(#{cargo})"
  end

  ##
  # To keep things immutable we need to make copies of the left
  # and right river bank items when we are creating a new game state
  # by applying the movement.

  def apply_movement(game_state)
    left_bank_copy = game_state.left_bank.reduce({}) do |m, (key, value)|
      m[key] = value if value; m
    end
    right_bank_copy = game_state.right_bank.reduce({}) do |m, (key, value)|
      m[key] = value if value; m
    end
    if cargo
      right_bank_copy[cargo] = false
      left_bank_copy[cargo] = true
    end
    PuzzleState.new(left_bank_copy, right_bank_copy, :left_bank)
  end

end

##
# Same explanation as for +MoveLeft+ except everthing is mirrored.

class MoveRight < Move

  def to_s
    "R(#{cargo})"
  end

  ##
  # Same reasoning as for +MoveRight+ movement application.

  def apply_movement(game_state)
    left_bank_copy = game_state.left_bank.reduce({}) do |m, (key, value)|
      m[key] = value if value; m
    end
    right_bank_copy = game_state.right_bank.reduce({}) do |m, (key, value)|
      m[key] = value if value; m
    end
    if cargo
      left_bank_copy[cargo] = false
      right_bank_copy[cargo] = true
    end
    PuzzleState.new(left_bank_copy, right_bank_copy, :right_bank)
  end

end

##
# Contains the items on the left bank, the right bank and the farmers
# current position. Also, has methods for generating new possible moves
# checking the validity of the current state and determining whether we
# are in a solved state.

class PuzzleState
  attr_reader :left_bank, :right_bank
  attr_writer :farmer_position

  @@disallowed_pairs = [[:w, :g], [:g, :c]]

  ##
  # Set up the seed state that we are going to explore with moves.

  def initialize(left_bank = nil, right_bank = nil, farmer_position = nil)
    @left_bank = left_bank || {:w => true, :g => true, :c => true}
    @right_bank = right_bank || {}
    @farmer_position = farmer_position || :left_bank
  end

  ##
  # If everything satisfies the constraints of the puzzle then we
  # have a valid state.

  def valid?
    case @farmer_position
    when :left_bank
      @@disallowed_pairs.each do |one, two|
        if @right_bank[one] && @right_bank[two]
          return false
        end
      end
      true
    when :right_bank
      @@disallowed_pairs.each do |one, two|
        if @left_bank[one] && @left_bank[two]
          return false
        end
      end
      true
    else
      raise StandardError, "Unknown farmer position: #{@farmer_position}."
    end
  end

  ##
  # We have solved the puzzle if all the items are on the right bank
  # along with the farmer.

  def solved?
    @left_bank.values.all? {|x| !x} &&
     @right_bank.values.all? {|x| x} &&
     @farmer_position == :right_bank
  end

  ##
  # Depending on which side of the river the farmer is and what's
  # on that side of the river bank we generate possible moves, e.g.
  # +MoveLeft+ or +MoveRight+ with potential cargo items. If the puzzle
  # has been solved then there are no more moves to generate so we return
  # an empty array.

  def possible_moves
    if solved?
      return []
    end
    case @farmer_position
    when :left_bank
      items = @left_bank.keys.select {|item| @left_bank[item]}
      items << nil
      items.map {|item| MoveRight.new(item)}
    when :right_bank
      items = @right_bank.keys.select {|item| @right_bank[item]}
      items << nil
      items.map {|item| MoveLeft.new(item)}
    else
      raise StandardError, "Unknown farmer position: #{@farmer_position}."
    end
  end

end

##
# Encapsulates the logic for expanding the seed state and pruning
# invalid states until we reach a solved state.

class PuzzleStateExplorer

  ##
  # Keeps track of the state along with the history of moves
  # that got us to that state.

  class StateAndMoveHistory < Struct.new(:state, :history)
    def pretty_print_history
      history.map {|move| move.to_s}.join(", ")
    end
  end

  def initialize
    @states = [StateAndMoveHistory.new(PuzzleState.new, [])]
  end

  ##
  # Get possible moves for each state and apply the moves to
  # get a new set of states. We don't bother to prune silly moves
  # like moving left then right without any cargo.

  def expand_states
    @states = @states.flat_map do |state_and_history|
      state = state_and_history.state
      history = state_and_history.history
      state.possible_moves.map do |move|
        new_state = move.apply_movement(state)
        StateAndMoveHistory.new(new_state, history + [move])
      end
    end
  end

  def prune_invalid_states
    @states.select! {|state_history| state_history.state.valid?}
  end

  def solution_found?
    @states.select {|state_history| state_history.state.solved?}.first
  end

  ##
  # Return a solution if one has been found otherwise expand and prune.

  def explore
    if (solution = solution_found?)
      return solution
    end
    expand_states
    prune_invalid_states
  end

end
