#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

DIRS = {
  n: [0, -1],
  s: [0, 1],
  w: [-1, 0],
  e: [1, 0]
}

MIRRORS = {
  ?| => {
    w: [:n ,:s],
    e: [:n ,:s],
    n: [:n],
    s: [:s]
  },
  ?- => {
    n: [:w ,:e],
    s: [:w ,:e],
    w: [:w],
    e: [:e]
  },
  "/" => {
    n: [:e],
    e: [:n],
    s: [:w],
    w: [:s]
  },
  "\\" => {
    n: [:w],
    e: [:s],
    s: [:e],
    w: [:n]
  },
  ?. => {
    n: [:n],
    e: [:e],
    w: [:w],
    s: [:s]
  }
}

grid = input.each_line.map { _1.strip.chars }

width = grid.first.length
height = grid.count

paths = [[-1, 0, :e]]
visited = Set.new

while paths.any?
  *pos, dir = paths.pop

  x, y = DIRS[dir].zip(pos).map(&:sum)

  next if x < 0 || y < 0 || x >= width || y >= height

  cell = grid[y][x]

  MIRRORS[cell][dir].each do |dir2|
    path = [x, y, dir2]

    if !visited.include?(path)
      paths << path
      visited << path
    end
  end
end

visited
  .map { |*pos, _| pos }
  .uniq
  .count
  .tap { puts _1 }
