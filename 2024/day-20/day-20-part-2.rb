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

    (-20..20).each do |dx|
      (-20..20).each do |dy|
          dur = dx.abs + dy.abs

          x1 = x + dx
          y1 = y + dy

          next if dur > 20
          next if x1 < 0 || y1 < 0 || x1 >= width || y1 >= height
          next if grid[y1][x1] == ?#
          next if (visited[[x1, y1]] - steps - dur) < 100

          savings << (visited[[x1, y1]] - steps - dur)
      end
    end

    savings
  }
  .tally
  .tap { puts _1.values.sum }
  #.tap { _1.sort.each { |sav, freq| p [freq, sav] } }
