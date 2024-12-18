#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split.map(&:chars).map { _1.map(&:to_i) }

width = grid[0].size
height = grid.size

start = input.split.flat_map { _1.chars }.each
  .map.with_index { _2 if _1 == ?0 }
  .compact
  .map { [_1 % width,  _1 / width] }

start.sum { |x, y|
  score = 0
  queue = [[x, y, 0]]

  while queue.any?
    x, y, lvl = queue.pop

    [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
      .reject { _1 < 0 || _2 < 0 || _1 >= width || _2 >= height }
      .select { grid[_2][_1] == lvl + 1 }
      .each {
        if lvl + 1 == 9
          score += 1
        else
          queue << [_1, _2, lvl + 1]
        end
      }
  end

  score
}.tap { puts _1 }
