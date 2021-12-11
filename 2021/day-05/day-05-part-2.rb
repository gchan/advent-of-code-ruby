#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

lines = []

input.split("\n").each do |line|
  lines << line.split(/,| -> /).map(&:to_i)
end

size = lines.flatten.max + 1

grid = Array.new(size) { Array.new(size, 0) }

lines.each do |(x1, y1, x2, y2)|
  xd = 1
  yd = 1

  xd = -1 if x1 > x2
  yd = -1 if y1 > y2

  xd = 0 if x1 == x2
  yd = 0 if y1 == y2

  length = [(x1 - x2).abs, (y1 - y2).abs].max + 1

  length.times do |idx|
    grid[y1 + idx * yd][x1 + idx * xd] += 1
  end
end

puts grid.flatten.count { |x| x >= 2 }
