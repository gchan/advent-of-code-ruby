#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.each_line.map { _1.strip.chars }

width = grid.first.count
height = grid.count

y_expand = height.times.select {
  grid[_1].join.match?(/\A\.*\z/)
}

transposed_grid = grid.transpose

x_expand = width.times.select {
  transposed_grid[_1].join.match?(/\A\.*\z/)
}

y_expand.each_with_index { |row, idx|
  grid.insert(row + idx, Array.new(width, "."))
}

height = grid.count
grid = grid.transpose

x_expand.each_with_index { |row, idx|
  grid.insert(row + idx, Array.new(height, "."))
}

grid = grid.transpose
width = grid.first.count

height.times.to_a
  .product(width.times.to_a)
  .select { grid[_1][_2] == ?# }
  .map { [_2, _1] }
  .combination(2)
  .sum { |(x1, y1), (x2, y2)| (x1 - x2).abs + (y1 - y2).abs }
  .tap { puts _1 }

