#!/usr/bin/env ruby

# Solution not efficient enought for part 2, see part 2 for better solution

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.read(file_path)

cups = input.strip.chars.map(&:to_i)

current = cups.first

cups = cups.rotate(1)

100.times do
  slice = cups.take(3)
  cups = cups.drop(3)

  dest = current
  while
    dest = (dest - 2) % cups.size + 1
    break unless slice.include?(dest)
  end

  idx = cups.index(dest)
  cups = cups.rotate(idx + 1)

  cups = slice + cups

  current_index = (cups.index(current) + 1) % cups.size
  current = cups[current_index]
  cups = cups.rotate(current_index + 1)
end

puts cups.rotate(cups.index(1) + 1).join[0..-2]
