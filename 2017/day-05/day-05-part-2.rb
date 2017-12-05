#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

offsets = input.split("\n").map(&:to_i)

position = 0
jumps = 0

while position < offsets.length
  move = offsets[position]

  if offsets[position] >= 3
    offsets[position] -= 1
  else
    offsets[position] += 1
  end

  position += move

  jumps += 1
end

puts jumps
