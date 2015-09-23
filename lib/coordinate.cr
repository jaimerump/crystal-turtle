# @author Jaime Rump
# This class represents a coordinate on a grid. It's basically just
# a container for two ints.
class Coordinate

  # The x position of this coordinate
  def x
    @x
  end

  # The y position of this coordinate
  def y
    @y
  end

  # Creates a new coordinate given its x and y positions
  # @param [Integer] x The x position
  # @param [Integer] y The y position
  # @raise [ArgumentError] if one of the arguments isn't an integer
  def initialize(x = 0, y = 0)
    raise ArgumentError.new("#{x} is not an Integer") unless x.is_a? Integer
    raise ArgumentError.new("#{y} is not an Integer") unless y.is_a? Integer

    @x = x
    @y = y
  end

  # Comparison operator
  # @param [Object] object The object to compare to
  # @return [Boolean]
  def ==(object)
    return self.class.name == object.class.name && @x == object.x && @y == object.y
  end

  # Addition operator
  # @param [Coordinate] object The values to add to this coordinate
  # @return [Coordinate]
  # @raise [ArgumentError] if argument isn't a coordinate
  def +(object)
    raise ArgumentError.new("Argument must be a Coordinate") unless object.is_a? Coordinate
    @x += object.x
    @y += object.y
    return self
  end

  # Subtraction operator
  # @param [Coordinate] object The values to subtract from this coordinate
  # @return [Coordinate]
  # @raise [ArgumentError] if argument isn't a coordinate
  def -(object)
    raise ArgumentError.new("Argument must be a Coordinate") unless object.is_a? Coordinate
    @x -= object.x
    @y -= object.y
    return self
  end

  # Renders the coordinate as string
  # @return [String]
  def to_s
    "(#{@x}, #{@y})"
  end

end
