#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input     = File.read(file_path)

ranges = input.split("\n").map do |range|
  range.split("-").map(&:to_i)
end

ranges.sort!

merged_ranges = [ranges.shift]

ranges.each do |range|
  prev_range = merged_ranges.first

  if prev_range[1] >= range[0] - 1
    prev_range[1] = [prev_range[1], range[1]].max
  else
    merged_ranges.unshift(range)
  end
end

merged_ranges.sort!

allowed_count = 0

merged_ranges.each_cons(2) do |range_one, range_two|
  allowed_count += [range_two[0] - range_one[1] - 1, 0].max
end

puts allowed_count
