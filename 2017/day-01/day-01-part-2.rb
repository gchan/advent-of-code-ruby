#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

digits = input.chars

length = digits.length

puts digits.select
  .with_index { |d, idx| digits[(idx + length / 2) % length] == d }
  .map(&:to_i)
  .inject(:+)
