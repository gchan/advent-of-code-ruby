#!/usr/bin/env ruby

# Includes both part 1 and part 2 solutions

file_path = File.expand_path('day-10-input.txt', __dir__)
input     = File.read(file_path)

adapters = input.split("\n").map(&:to_i).sort

adapters.unshift(0)
adapters << adapters.last + 3

diffs = Hash.new(0)

adapters.each_cons(2) do |a, b|
  diff = b - a
  diffs[diff] += 1
end

puts diffs[1] * diffs[3]


pos = Hash.new(0)
pos[0] = 1

adapters.each do |a|
  3.times do |i|
    pos[a] += pos[a - i - 1]
  end
end

puts pos.values.max
