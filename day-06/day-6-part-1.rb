#!/usr/bin/env ruby

file_path    = File.expand_path("../day-6-input.txt", __FILE__)
instructions = File.readlines(file_path)

class Coordinate
  attr_reader :x, :y

  def initialize(string)
    x, y = string.split(",")

    @x = x.to_i
    @y = y.to_i
  end
end

grid = Array.new(1000) { Array.new(1000, false) }

instructions.each do |instruction|
  from_str = instruction.match(/\d+,\d+/)[0]
  to_str   = instruction.match(/\d+,\d+$/)[0]

  from = Coordinate.new(from_str)
  to   = Coordinate.new(to_str)

  if instruction =~ /off/
    command = :off
  elsif instruction =~ /on/
    command = :on
  else
    command = :toggle
  end

  (from.x..to.x).each do |x|
    (from.y..to.y).each do |y|
      case command
      when :on
        grid[x][y] = true
      when :off
        grid[x][y] = false
      when :toggle
        grid[x][y] = !grid[x][y]
      end
    end
  end
end

puts grid.flatten.count { |state| state }
