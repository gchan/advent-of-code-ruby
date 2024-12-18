#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

size = 71
grid = ("." * size * size).chars.each_slice(size).to_a
bytes = input.split.map { _1.split(?,).map(&:to_i) }

bytes[0..1023].each { |x, y|
  grid[y][x] = ?#
}

start = [0, 0]

queue = []
queue << [start, 0]

visited = Set.new

while queue.any?
  loc, steps = queue.pop
  x, y = loc

  candidates = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]

  candidates
    .reject { _1 < 0 || _2 < 0 || _1 >= size || _2 >= size }
    .reject { grid[_2][_1] == ?# }
    .reject { visited.include?([_1, _2]) }
    .each {
      if _1 == size - 1 && _2 == size - 1
        puts steps + 1
        exit
      end

      visited.add([_1, _2])
      queue.unshift [[_1, _2], steps + 1]
    }
end
