#!/usr/bin/env ruby

# Identical to Part 1

require 'set'

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input = File.read(file_path)

grid = input.split("\n").map do |row|
  row.split("")
end

y = 0
x = grid[y].index("|")
direction = :down

steps = 0
visited = Set.new
chars = []

until grid[y][x] == ' '
  steps += 1
  visited.add([y,x])

  case direction
  when :down
    y += 1
  when :up
    y -= 1
  when :left
    x -= 1
  when :right
    x += 1
  end

  cell = grid[y][x]

  case cell
  when '+'
    neighbours = [
      [:right, y, x + 1],
      [:left, y, x - 1],
      [:up, y - 1, x],
      [:down, y + 1, x]
    ]

    neighbours.each do |dir, y, x|
      next if y < 0 || x < 0 || y >= grid.size || x >= grid[y].size
      next if visited.include?([y,x])

      direction = dir if grid[y][x] != ' '
    end
  when /\w/
    chars << cell
  end
end

puts chars.join
puts steps
