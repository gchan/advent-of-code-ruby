#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

steps = input.to_i

buffer = [0]
pos = 0

2017.times do |i|
  pos = (pos + steps) % buffer.size + 1
  buffer.insert(pos, i + 1)
end

puts buffer[pos + 1]
