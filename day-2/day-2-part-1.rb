#!/usr/bin/env ruby

file_path = File.expand_path("../day-2-input.txt", __FILE__)
input     = File.read(file_path)

total = 0

input.split("\n").each do |present|
  sides = present.split("x").map(&:to_i)

  areas = sides.combination(2).map do |side_one, side_two|
    side_one * side_two
  end

  total += areas.inject(:+) * 2
  total += areas.min
end

puts total
