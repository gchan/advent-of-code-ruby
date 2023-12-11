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

height.times.to_a
  .product(width.times.to_a)
  .select { grid[_1][_2] == ?# }
  .map { [_2, _1] }
  .combination(2)
  .sum { |(x1, y1), (x2, y2)|
    x_range = Range.new(*[x1, x2].sort)
    y_range = Range.new(*[y1, y2].sort)

    x_range.size + y_range.size - 2 +
      999_999 * x_expand.count { x_range.include?(_1) } +
      999_999 * y_expand.count { y_range.include?(_1) }
  }
  .tap { puts _1 }
