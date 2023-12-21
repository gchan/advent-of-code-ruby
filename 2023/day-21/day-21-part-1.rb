#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.each_line.map { _1.strip.chars }

w = grid.first.count
h = grid.count

idx = grid.flatten.index(?S)

y = idx / h
x = idx % h

queue = [[x, y, 0]]

visited = {}
visited[[x,y]] = 0

while queue.any?
  x, y, step = queue.shift

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
    x1, y1 = dir.zip([x,y]).map(&:sum)

    next if x1 < 0 || y1 < 0 || x1 >= w || y1 >= h

    c = grid[y1][x1]

    next if c == ?#
    next if visited[[x1, y1]]

    visited[[x1,y1]] = step + 1
    queue << [x1, y1, step + 1]
  end
end

visited.values
  .count { _1 <= 64 && _1.even? }
  .tap { pp _1 }
