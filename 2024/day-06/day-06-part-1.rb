#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split.map(&:chars)

width = grid[0].size
height = grid.size

loc = input.split.join.index(?^)

x = loc % width
y = loc / width

dir = [0, -1]
pos = [x, y]

visited = Set.new([[x, y]])

while true
  next_pos = pos.zip(dir).map { _1.inject(:+) }
  x, y = next_pos

  break if x < 0 || x >= width || y < 0 || y >= height

  if grid[y] && grid[y][x] == ?#
    dir = [-dir[1], dir[0]]
  else
    pos = next_pos
    visited.add(pos)
  end
end

puts visited.count
