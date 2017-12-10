#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

lengths = input.split(",").map(&:to_i)

size = 256
list = (0..(size - 1)).to_a

idx = 0
skip = 0

lengths.each do |length|
  sublist = list[idx, length]
  sublist.concat(list[0, idx + length - size]) if idx + length - 1 >= size

  sublist.reverse!

  list[idx, length] = sublist.slice!(0, size - idx)
  list[0, idx + length - size] = sublist if sublist.any?

  idx = (idx + length + skip) % size
  skip += 1
end

puts list[0] * list[1]
