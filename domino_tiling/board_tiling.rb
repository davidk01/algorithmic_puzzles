require 'pp'

##
# We will start filling the board from the top, left corner. We will represent a horizontal
# domino with :-,:- and a vertical domino with :|,:| but stacked on top of one another instead
# of next to each other. A cell with a zero represents an empty cell.

class Board < Struct.new(:partial_board)

  ##
  # Go row by row until we find an empty cell. Not the most efficient way of going about
  # it but should be good enough for board expansion.

  def find_empty_cell
    (0..7).each do |row_index|
      row = partial_board[row_index]
      (0..7).each do |column_index|
        if row[column_index] == 0
          return [row_index, column_index]
        end
      end
    end
  end

  ##
  # A full board does not have any zeros. Zero is our way of saying that cell is empty.

  def full_board?
    !partial_board.any? {|row| row.any? {|x| x == 0}}
  end

  ##
  # If the previous column has a vertical domino or we are in the last row then we
  # can not place a vertical domino at this position because we would get a board
  # that does not satisfy the constraints of the puzzle. We also have to worry about
  # being in the very first column because if we are then there can not possibly be any
  # vertical obstructions.

  def vertical_obstruction?(cell_coords)
    row_index, column_index = cell_coords
    row_index == 7 || (column_index > 0 && partial_board[row_index][column_index - 1] == :| &&
     partial_board[row_index + 1][column_index - 1] == :|)
  end

  ##
  # Almost same logic as above with a twist or two.

  def horizontal_obstruction?(cell_coords)
    row_index, column_index = cell_coords
    column_index == 7 || !(partial_board[row_index][column_index + 1] == 0) || (row_index > 0 &&
     partial_board[row_index - 1][column_index] == :- &&
     partial_board[row_index - 1][column_index + 1] == :-)
  end

  ##
  # To figure out possible expansions we need the row above, current row, and the row
  # below the empty cell. We also need to be careful with boundary conditions which means
  # we can't just take the current row and subtract 1 because in some cases we will get -1
  # which is not what we want.

  def possible_expansions
    if (cell_coords = find_empty_cell).nil?
      raise StandardError, "Board is already full."
    end
    row_index, column_index = cell_coords
    possible_expansions = []
    possible_expansions << :horizontal unless horizontal_obstruction?(cell_coords)
    possible_expansions << :vertical unless vertical_obstruction?(cell_coords)
    possible_expansions.map do |expansion_mode|
      board_copy = partial_board.map {|row| row.dup}
      case expansion_mode
      when :vertical
        board_copy[row_index][column_index] = :|
        board_copy[row_index + 1][column_index] = :|
        Board.new(board_copy)
      when :horizontal
        board_copy[row_index][column_index] = :-
        board_copy[row_index][column_index + 1] = :-
        Board.new(board_copy)
      else
        raise StandardError, "Unknown expansion mode: #{expansion_mode}."
      end
    end
  end

end

##
# Keep expanding the seed states until we get a full board or get back an empty array.
# If we get back an empty array then we know that a solution is not possible.

def expander(seed_boards)
  puts "Expanding states."
  expansions = seed_boards.flat_map {|seed_state| seed_state.possible_expansions}
  if expansions.any?(&:full_board?)
    puts "Solution found."
    return expansions.select {|x| x.full_board?}.first
  elsif expansions.empty?
    puts "No solution possible."
    seed_boards.each {|b| pp b.partial_board.map {|row| row.map {|x| x == 0 ? :+ : x}}}
    return
  end
  expander(expansions)
end

seed_board = Board.new((0..7).map {|i| [0] * 8})
solution = expander([seed_board])
if solution
  pp solution.partial_board
end
