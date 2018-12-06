#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

ords = input.split("\n").map do |ord|
  x, y = ord.split(",").map(&:to_i)
end

rows = ords.map(&:first).max + 1
cols = ords.map(&:last).max + 1

count = 0

rows.times do |x|
  cols.times do |y|
    sum = ords.map.inject(0) do |sum, (x1, y1)|
      sum + (x - x1).abs + (y - y1).abs
    end

    count += 1 if sum < 10000
  end
end

puts count
