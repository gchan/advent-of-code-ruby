#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
presents  = File.readlines(file_path)

total = 0

presents.each do |present|
  sides = present.split("x").map(&:to_i)

  # Wrap
  total += sides.sort.min(2).inject(:+) * 2
  # Bow
  total += sides.inject(:*)
end

puts total
