# @author Jaime Rump
# This class represents a canvas for a turtle to move across.
# It's basically just a 2D array of strings.
#

require "./coordinate"

class Canvas

  # @!attribute [r] grid
  #   The grid that the canvas represents, it's a 2D array of strings
  #   Each inner array is a row, and each entry is a cell
  @grid = [] of Array(String)

  # The string used to represent untouched cells
  UNTRAVERSED_CELL_STRING = "."
  # The string used to represent cells that have been traversed
  TRAVERSED_CELL_STRING = "X"
  # The string used to separate columns in the output
  COLUMN_SEPARATOR = " "
  # The string used to separate rows in the output
  ROW_SEPARATOR = "\n"


  # Functions

  # Creates the canvas from the given length
  # @param [Integer] length The length of the sides
  # @return [Canvas]
  # @raise [ArgumentError] if the length is not an integer, not positive, or is even
  def initialize(length)
    raise ArgumentError.new("#{length} is not an Integer") unless length.is_a? Integer
    raise ArgumentError.new("length must be greater than 0") if length <= 0
    raise ArgumentError.new("length must be an odd number") if length.even?

    @grid = Array.new(length)
    for i in 0..(length - 1)
      @grid[i] = Array.new(length, UNTRAVERSED_CELL_STRING)
    end
  end

  # The coordinate for the center of the grid
  # @return [Coordinate]
  def center
    x = (@grid.length.to_f / 2).floor # Keep in mind off-by-one
    Coordinate.new(x, x)
  end

  # The character at the given coordinate
  # @param [Coordinate] coord The coordinate to get the character from
  # @return [String]
  # @raise [ArgumentError] if the argument is not a coordinate
  # @raise [RangeError] if the coordinate is outside of the canvas
  def character_at(coordinate)
    raise ArgumentError.new("Argument is not a Coordinate") unless coordinate.is_a? Coordinate
    raise RangeError.new("coordinate #{coordinate.to_s} is outside of the canvas") if coordinate.x >= @grid.length || coordinate.y >= @grid.length || coordinate.x < 0 || coordinate.y < 0

    @grid[coordinate.y][coordinate.x]
  end

  # Marks the given coordinate as having been traversed
  # @param [Coordinate] coordinate The coordinate to mark
  # @raise [RangeError] if the coordinate is outside of the canvas
  def mark_as_traversed(coordinate)
    raise ArgumentError.new("Argument is not a Coordinate") unless coordinate.is_a? Coordinate
    raise RangeError.new("coordinate #{coordinate.to_s} is outside of the canvas") if coordinate.x >= @grid.length || coordinate.y >= @grid.length || coordinate.x < 0 || coordinate.y < 0

    # Y is row, x is column
    @grid[coordinate.y][coordinate.x] = TRAVERSED_CELL_STRING
  end

  # Gives a nice pretty string version of the grid
  # @return [String]
  def print
    lines = [] of String

    @grid.each do |row|
      lines.push(row.join(COLUMN_SEPARATOR))
    end

    lines.join(ROW_SEPARATOR)
  end


