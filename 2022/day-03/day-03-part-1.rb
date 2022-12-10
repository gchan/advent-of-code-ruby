#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

priorities = input.each_line.map { |runsack|
  compartments = runsack.strip.chars.each_slice(runsack.length / 2).to_a
  error = (compartments[0] & compartments[1]).first

  priority = error.downcase != error ? 26 : 0
  priority += error.downcase.ord - 'a'.ord + 1
}

puts priorities.sum
