#!/usr/bin/env ruby

file_path = File.expand_path('day-03-input.txt', __dir__)
input     = File.read(file_path)

map = input.split("\n").map { |line| line.split('') }

x, y, trees = 0, 0, 0
dx = 3
dy = 1

while y < map.length - 1
  x += dx
  x %= map[0].length
  y += dy

  trees += 1 if map[y][x] == '#'
end

puts trees
