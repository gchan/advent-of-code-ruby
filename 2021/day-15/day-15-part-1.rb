#!/usr/bin/env ruby

require "set"

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

def find_neighbours(grid, x ,y)
  width = grid[0].length
  height = grid.length

  neighbours = [
    [x - 1, y],
    [x + 1, y],
    [x, y + 1],
    [x, y - 1]
  ]

  neighbours.select do |x1, y1|
    x1 >= 0 && x1 < width &&
    y1 >= 0 && y1 < height
  end
end

grid = input.split("\n").map(&:chars).map { |row| row.map(&:to_i) }

queue = [[0, 0]]
visited = queue.to_set

risks = {
  [0, 0] => 0
}

while queue.any?
  x, y = queue.shift

  current_risk = risks[[x, y]]

  find_neighbours(grid, x, y).each do |x1, y1|
    coord = [x1, y1]
    risk = grid[y1][x1]

    new_risk = current_risk + risk

    next if risks[coord] && risks[coord] < new_risk

    risks[coord] = new_risk

    next if visited.include?(coord)

    queue << coord
    visited.add(coord)
  end
end

width = grid[0].length
height = grid.length

puts risks[[height - 1, width - 1]]
