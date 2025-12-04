#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split("\n").map.map(&:chars)

count = 0

grid.each_with_index do |row, x|
  row.each_with_index do |char, y|
    next if char == ?.

    neighbours = 0
    (x - 1..x+ 1).each do |r|
      (y - 1..y+ 1).each do |c|
        next if r == x && c == y
        next if r < 0 || r >= grid.length
        next if c < 0 || c >= grid[0].length
        neighbours += 1 if grid[r][c] != ?.
      end
    end

    count += 1 if neighbours < 4
  end
end

puts count
