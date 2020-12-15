#!/usr/bin/env ruby

# Includes both part 1 and part 2 solutions

file_path = File.expand_path('day-15-input.txt', __dir__)
input     = File.read(file_path)

nums = input.split(",").map(&:to_i)

spoken = Hash.new { |h, k| h[k] = Array.new }

nums.each.with_index do |i, idx|
  spoken[i] << idx
end

idx = nums.count
last = nums.last

while idx < 30000000
  if spoken[last].count > 1
    last = spoken[last].last(2).inject(:-).abs
  else
    last = 0
  end

  spoken[last] << idx

  idx += 1

  puts last if idx == 2020
end

puts last
