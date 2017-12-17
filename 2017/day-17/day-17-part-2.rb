#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

steps = input.to_i
pos = 0

size = 1
val = nil

50000000.times do |i|
  pos = (pos + steps) % size + 1

  val = i + 1 if pos == 1
  size += 1
end

puts val
