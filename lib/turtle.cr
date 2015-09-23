# @author Jaime Rump
# This class represents a turtle. A turtle is an object that moves around a grid,
# with its movements described as an angle and a scalar.

require "./coordinate"
require "./canvas"

class Turtle

  # @!attribute [r] angle
  #   The direction in which the turtle is facing, as an angle in degrees.
  #   0 degrees represents the x axis. The turtle starts facing straight up,
  #   so 90 degrees. For the purposes of this project, the angle must be a
  #   multiple of 45 degrees. The angle must be between 0 and 360 degrees.
  def angle
    @angle
  end

  # @!attribute [r] position
  #   The position the turtle is currently in on the canvas as a Coordinate
  #   Defaults to the center of the canvas
  def position
    @position
  end

  # @!attribute [r] canvas
  #   The canvas the turtle is moving across.
  def canvas
    @canvas
  end

  # @!attribute [rw] step
  #   A coordinate representing how far, on each step, the turtle will move
  #   horizontally and vertically based on its current angle
  def step
    @step
  end


  # Functions

  # Initializes the turtle and puts it at the center of the given canvas
  # @param [Canvas] canvas The canvas to put the turtle on
  # @return [Turtle]
  # @raise [ArgumentError] if the argument is not a Canvas
  def initialize(canvas)
    raise ArgumentError.new("Argument is not a Canvas") unless canvas.is_a? Canvas

    @canvas = canvas
    @position = canvas.center
    @angle = 90
    @step = Coordinate.new(0, -1)
  end

  # Turns the turtle counter-clockwise by $change degrees.
  # If the angle passes 360, it loops back around 0.
  # @param [Integer] change The amount to change the angle by
  # @raise [ArgumentError] if the angle isn't an integer multiple of 45
  def turn_left(change)
    raise ArgumentError.new("#{change} is not an Integer") unless change.is_a? Integer
    raise ArgumentError.new("#{change} is not a multiple of 45") if change % 45 != 0

    @angle = (@angle + (change % 360)) % 360

    recalculate_step
  end

  # Turns the turtle clockwise by $change degrees.
  # If the angle passes 0, it loops back around 360.
  # @param [Integer] change The amount to change the angle by
  # @raise [ArgumentError] if the angle isn't an integer multiple of 45
  def turn_right(change)
    raise ArgumentError.new("#{change} is not an Integer") unless change.is_a? Integer
    raise ArgumentError.new("#{change} is not a multiple of 45") if change % 45 != 0

    if change > @angle
      turn_left(360 - (change % 360 ))
    else
      @angle = @angle - (change % 360)
    end

    recalculate_step
  end

  # Updates the step coordinate when needed
  def recalculate_step
    # Calculate horizontal step
    if @angle == 90 || @angle == 270
      horizontal_step = 0
    elsif @angle > 90 && @angle < 270
      horizontal_step = -1
    else
      horizontal_step = 1
    end

    # Calculate vertical step
    if @angle == 0 || @angle == 180
      vertical_step = 0
    elsif @angle > 0 && @angle < 180
      vertical_step = -1
    else
      vertical_step = 1
    end

    @step.x = horizontal_step
    @step.y = vertical_step
  end

  # Moves the turtle forward (from its perspective) by $num_steps spaces.
  # If it is facing diagonally, it moves both horizontally and vertically
  # by one space.
  # @param [Integer] num_steps The number of steps to take
  # @raise [ArgumentError] if the argument isn't an integer
  # @raise [RangeError] if the turtle walks off the canvas
  def move_forward(num_steps)
    raise ArgumentError.new("Argument must be an Integer") unless num_steps.is_a? Integer

    begin
      num_steps.times do
        @position += @step
        @canvas.mark_as_traversed(@position)
      end

    rescue RangeError
      raise RangeError.new("Turtle fell off the Canvas")
    end

  end

  # Moves the turtle backward (from its perspective) by $num_steps spaces.
  # If it is facing diagonally, it moves both horizontally and vertically
  # by one space.
  # @param [Integer] num_steps The number of steps to take
  # @raise [RangeError] if the turtle backs off the canvas
  def move_backward(num_steps)
    raise ArgumentError.new("Argument must be an Integer") unless num_steps.is_a? Integer

    begin
      num_steps.times do
        @position -= @step
        @canvas.mark_as_traversed(@position)
      end

    rescue RangeError
      raise RangeError.new("Turtle fell off the Canvas")
    end
  end

end
