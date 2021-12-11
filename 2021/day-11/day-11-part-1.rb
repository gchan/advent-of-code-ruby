#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

def find_neighbours(grid, x ,y)
  width = grid[0].length
  height = grid.length

  neighbours = [x - 1, x, x + 1].product([y - 1, y, y + 1])

  neighbours.select do |x1, y1|
    x1 >= 0 && x1 < width &&
    y1 >= 0 && y1 < height &&
    (x1 != x || y1 != y)
  end
end

grid = input.split("\n").map(&:chars).map { |row| row.map(&:to_i) }

flash_count = 0

100.times do
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      grid[y][x] += 1
    end
  end

  flashed = Set.new

  queue = []

  queue.concat(
    (0..grid[0].length - 1).to_a.product((0..grid.length - 1).to_a)
  )

  while queue.any? do
    x, y = queue.shift

    next if flashed.include?([x, y])

    cell = grid[y][x]

    if cell > 9
      flashed.add([x, y])

      find_neighbours(grid, x, y).each do |x1, y1|
        grid[y1][x1] += 1
        queue << [x1, y1]
      end
    end
  end

  flashed.each do |x, y|
    grid[y][x] = 0
  end

  flash_count += flashed.size
end

puts flash_count
