#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split.map(&:chars)

width = grid[0].size
height = grid.size

start = input.split.join.index(?S)
start = [start % width, start / height]

visited = {}
visited[start] = 0

queue = []
queue << [0, start]

while queue.any?
  queue.sort_by!(&:first)
  steps, loc = queue.shift

  x, y = loc
  candidates = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]

  candidates
    .reject { _1 < 0 || _2 < 0 || _1 >= width || _2 >= height }
    .reject { grid[_2][_1] == ?# }
    .reject { visited[[_1, _2]] }
    .each {
      visited[[_1, _2]] = steps + 1

      if grid[_2][_1] != ?E
        queue.unshift([steps + 1, [_1, _2]])
      end
    }
end

visited
  .flat_map { |loc, steps|
    x, y = loc

    savings = []
    candidates = [[x + 2, y], [x - 2, y], [x, y + 2], [x, y - 2]]

    candidates
      .reject { _1 < 0 || _2 < 0 || _1 >= width || _2 >= height }
      .reject { grid[_2][_1] == ?# }
      .select { (visited[[_1, _2]] - steps - 2) >= 100 }
      .each {
        savings << (visited[[_1, _2]] - steps - 2)
      }

    savings
  }
  .tally
  .tap { puts _1.values.sum }
  #.tap { _1.sort.each { |sav, freq| p [freq, sav] } }
