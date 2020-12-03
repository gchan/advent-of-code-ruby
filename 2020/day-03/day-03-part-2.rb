#!/usr/bin/env ruby

file_path = File.expand_path('day-03-input.txt', __dir__)
input     = File.read(file_path)

map = input.split("\n").map { |line| line.split('') }

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

puts slopes.map { |dx, dy|
  x = 0
  y = 0
  trees = 0

  while y < map.length - 1
    x += dx
    x %= map[0].length
    y += dy

    trees += 1 if map[y][x] == '#'
  end

  trees
}.reduce(:*)
