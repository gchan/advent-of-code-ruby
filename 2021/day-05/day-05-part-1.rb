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
  y2, y1 = y1, y2 if y2 < y1
  x2, x1 = x1, x2 if x2 < x1

  if x1 == x2
    (y1..y2).each do |y|
      grid[y][x1] += 1
    end
  elsif y1 == y2
    (x1..x2).each do |x|
      grid[y1][x] += 1
    end
  end
end

puts grid.flatten.count { |x| x >= 2 }
