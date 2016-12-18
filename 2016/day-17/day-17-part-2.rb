#!/usr/bin/env ruby

require 'digest'

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

class State
  attr_reader :x, :y, :path

  def initialize(x, y, path = "")
    @x = x
    @y = y
    @path = path
  end

  def next_states(code)
    return [] if complete?

    digest = Digest::MD5.hexdigest("#{code}#{path}")

    states = []

    digest[0..3].chars.zip(directions).each do |char, (x, y, direction)|
      next if x < 0 || x > 3 || y < 0 || y > 3
      states << State.new(x, y, path + direction) if char.match(/[b-f]/)
    end

    states
  end

  def directions
    [
      [x, y - 1, "U"],
      [x, y + 1, "D"],
      [x - 1, y, "L"],
      [x + 1, y, "R"]
    ]
  end

  def complete?
    x == 3 && y == 3
  end
end

queue = [State.new(0, 0)]
longest_path = 0

while queue.any? do
  state = queue.shift

  longest_path = [longest_path, state.path.length].max if state.complete?

  queue.concat(state.next_states(input))
end

puts longest_path
