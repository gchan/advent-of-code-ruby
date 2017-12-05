#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

offsets = input.split("\n").map(&:to_i)

position = 0
jumps = 0

while position < offsets.length
  move = offsets[position]
  offsets[position] += 1
  position += move

  jumps += 1
end

puts jumps
