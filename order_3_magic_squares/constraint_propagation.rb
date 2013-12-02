class PartialMagicSquare

  def initialize(partial_board)
    @partial_board = partial_board
    board_entries = partial_board.reduce({}) {|m, r| r.each {|i| m[i] = true}; m}
    @choices = (1..9).reject {|x| board_entries[x]}
  end

  ##
  # No +nil+ entries anywhere.

  def complete?
    @partial_board.all? {|r| !r.any? {|x| x.nil?}}
  end

  ##
  # Row, column, diagonal sums are all the same.

  def valid?
    # row checks
    complete_rows = @partial_board.reject {|r| r.any? {|x| x.nil?}}
    if (row = complete_rows.first)
      sum = row.reduce(&:+)
    else
      return true
    end
    return false unless complete_rows.all? {|r| r.reduce(&:+) == sum}
    # column checks
    complete_columns = @partial_board[0].zip(*@partial_board[1..-1])
    complete_columns.reject! {|col| col.any? {|x| x.nil?}}
    return false unless complete_columns.all? {|c| c.reduce(&:+) == sum}
    # diagonal checks, can only perform if the board is complete
    if @choices.empty?
      diag_sum = [[0, 0], [0, 2], [1, 1], [1, 1], [2, 0], [2, 2]].reduce(0) do |m, (r, c)|
        m + @partial_board[r][c]
      end
      return false unless diag_sum == 2 * sum
    end
    true
  end

  ##
  # Go row by row and find the very first empty cell.

  def find_empty_cell
    (0..2).each do |row_index|
      row = @partial_board[row_index]
      (0..2).each {|col_index| return [row_index, col_index] if row[col_index].nil?}
    end
  end

  ##
  # Try all the choices, for the first empty position and then reject all the
  # invalid boards.

  def expand
    row, col = find_empty_cell
    if row
      @choices.map do |entry|
        board_copy = @partial_board.map {|r| r.dup}
        board_copy[row][col] = entry
        PartialMagicSquare.new(board_copy)
      end.select {|s| s.valid?}
    else
      []
    end
  end

end

##
# Expand and accumulated complete and valid boards.

def expander(seed_states, accumulated)
  if seed_states.empty?
    accumulated
  else
    new_states = seed_states.flat_map {|x| x.expand}
    # don't need to check for validity because +expand+ already checks for validity
    complete, incomplete = new_states.partition {|x| x.complete?}
    expander(incomplete, accumulated + complete)
  end
end

seed_states = [PartialMagicSquare.new(([nil] * 9).each_slice(3).to_a)]
magic_squares = expander(seed_states, [])
puts "Number of order 3 magic squares: #{magic_squares.length}."
