#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

class Person
  attr_reader :x, :y, :dir

  def initialize
    @x = 0
    @y = 0
    @dir = 0
  end

  def move
    case dir
    when 0
      @y += 1
    when 1
      @x += 1
    when 2
      @y -= 1
    when 3
      @x -= 1
    end
  end

  def turn(input)
    if input == "L"
      @dir -= 1
    else # R
      @dir += 1
    end

    @dir %= 4
  end
end

person = Person.new

visited = Set.new

input.gsub(",", "").split.each do |cmd|
  person.turn(cmd[0])

  steps = cmd[1..-1].to_i

  steps.times do
    person.move

    x = person.x
    y = person.y

    if visited.include?([x, y])
      puts x.abs + y.abs
      exit
    end

    visited << [x, y]
  end
end
