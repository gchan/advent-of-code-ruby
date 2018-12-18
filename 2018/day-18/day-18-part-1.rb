#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

rows = input.split("\n")

grid = Array.new(rows.size) { Array.new(rows.first.size) }

rows.each.with_index do |row, y|
  row.chars.each.with_index do |cell, x|
    grid[y][x] = cell
  end
end

def neighbours(x1, y1, grid)
  [x1 - 1, x1, x1 + 1].product([y1 - 1, y1, y1 + 1])
    .reject { |x, y| x == x1 && y == y1 }
    .reject { |x, y| x < 0 || y < 0 || x >= grid[0].size || y >= grid.size }
    .map { |x, y| grid[y][x] }
end

10.times do
  new_grid = Array.new(rows.size) { Array.new(rows.first.size) }

  grid.each.with_index do |row, y|
    row.each.with_index do |cell, x|
      adjacent = neighbours(x, y, grid)

      trees = adjacent.count { |c| c == "|" }
      lumber = adjacent.count { |c| c == "#" }

      case cell
      when "."
        cell = "|" if trees >= 3
      when "|"
        cell = "#" if lumber >= 3
      when "#"
        cell = "." if lumber == 0 || trees == 0
      end

      new_grid[y][x] = cell
    end
  end

  grid = new_grid
end

trees = grid.flatten.count { |c| c == "|" }
lumber = grid.flatten.count { |c| c == "#" }

puts trees * lumber
