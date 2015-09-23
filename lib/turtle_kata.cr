# @author Jaime Rump
# This class runs the turtle kata on a logo file

require "./turtle"

class TurtleKata

  # Runs the turtle kata with the given instruction file
  # @param [String] filename The name of the file to use
  def self.run_with_file(filename)
    # Read in the file
    file = File.new(filename, 'r')

    # Create the canvas
    line = file.gets
    size = line.to_i
    canvas = Canvas.new(size)
    turtle = Turtle.new(canvas)

    # Skip line
    file.gets

    # Run the instructions
    while (line = file.gets)
      run_instruction(line, turtle)
    end

    # Print the result
    puts canvas.print
  end

  # Parses an instruction and runs it
  # @param [String] instruction The instruction to run
  # @param [Turtle] turtle The turtle to run the instruction on
  # @raise [ArgumentError] if command isn't recognized or turtle is bad
  def self.run_instruction(instruction, turtle)
    raise ArgumentError.new("Instruction must be a string") unless instruction.is_a? String
    raise ArgumentError.new("You must pass in a Turtle") unless turtle.is_a? Turtle

    parts = instruction.split(" ", 2)
    command = parts.first
    arguments = parts.last

    case command
    when "FD"
      turtle.move_forward(arguments.to_i)
    when "BK"
      turtle.move_backward(arguments.to_i)
    when "RT"
      turtle.turn_right(arguments.to_i)
    when "LT"
      turtle.turn_left(arguments.to_i)
    when "REPEAT"
      # Figure out how many times to iterate
      parts = arguments.split(' ', 2)
      num_times = parts.first.to_i

      # Pull out the bracketed stuff
      bracketed_text = parts.last.scan(/\[([^\]]+)\]/).last.last # Returns double nested array

      # Split bracketed text into instructions
      bracketed_instructions = bracketed_text.scan(/[A-Z]+\s\d+/)

      # Loop the given number of times
      num_times.times do

        # Perform each instruction
        bracketed_instructions.each do |bracketed_instruction|
          run_instruction(bracketed_instruction, turtle)
        end

      end

    else
      raise ArgumentError.new("Invalid instruction #{command}")
    end
  end

end