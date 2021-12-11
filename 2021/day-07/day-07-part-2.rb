#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

positions = input.split(",").map(&:to_i)

min, max = positions.minmax

fuel_totals = Array.new(max + 1, 0)

positions.each do |pos|
  fuel = 0

  (pos..max).each_with_index do |x, idx|
    fuel += idx
    fuel_totals[x] += fuel
  end

  fuel = 0

  (min..pos).each_with_index do |x, idx|
    fuel += idx
    fuel_totals[pos-x] += fuel
  end
end

puts fuel_totals.min
