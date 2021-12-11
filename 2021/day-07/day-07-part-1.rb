#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

positions = input.split(",").map(&:to_i)

min, max = positions.minmax

fuel_totals = Array.new(max + 1, 0)

positions.each do |pos|
  (min..max).each do |x|
    fuel_totals[x] += (pos - x).abs
  end
end

puts fuel_totals.min
