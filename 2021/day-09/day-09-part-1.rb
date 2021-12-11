#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split("\n").map { |line| line.split("").map(&:to_i) }

width = grid[0].length
height = grid.length

risk = 0

grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    neighbours = [
      [x - 1, y],
      [x + 1, y],
      [x, y + 1],
      [x, y - 1]
    ]

    neighbours.select! do |x1, y1|
      x1 >= 0 && x1 < width &&
      y1 >= 0 && y1 < height
    end

    if neighbours.all? { |x1, y1| grid[y1][x1] > cell }
      risk += cell + 1
    end
  end
end

puts risk
