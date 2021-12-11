#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split("\n").map { |line| line.split("").map(&:to_i) }

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

def find_equal_or_higher_neighbours(grid, x, y)
  cell = grid[y][x]

  find_neighbours(grid, x, y).select do |x1, y1|
    grid[y1][x1] < 9 && grid[y1][x1] >= cell
  end
end

basin_sizes = []

grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    next if cell == 9

    queue = find_neighbours(grid, x, y)

    if queue.all? { |x1, y1| grid[y1][x1] > cell }
      visited = Set.new
      visited.add([x,y])

      basin_size = 1

      while queue.any? do
        x1, y1 = queue.shift
        next if visited.include?([x1, y1])
        visited.add([x1, y1])

        basin_size += 1

        queue.concat(
          find_equal_or_higher_neighbours(grid, x1, y1)
        )
      end

      basin_sizes << basin_size
    end
  end
end

puts basin_sizes.sort.reverse[0, 3].inject(&:*)
