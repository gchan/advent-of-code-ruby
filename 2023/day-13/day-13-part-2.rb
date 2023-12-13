#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

def row_count(grid)
  (grid.count - 1)
    .times
    .map { |y|
      left = grid[0..y].reverse
      right = grid[y+1..]

      errors = left.zip(right).select(&:last).sum { |l, r|
        l.zip(r).count { _1 != _2 }
      }

      left.count if errors == 1
    }
    .compact
    .first
end

input
  .split("\n\n")
  .map { |pattern|
    grid = pattern.each_line.map(&:strip).map(&:chars)

    row_count(grid.transpose) || row_count(grid) * 100
  }
  .sum
  .tap { puts _1 }

