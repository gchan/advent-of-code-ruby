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

pos = [x, y]

def travel(grid, start)
  dir = [0, -1]
  pos = start
  visited = Set.new([[pos, dir]])

  width = grid[0].size
  height = grid.size

  while true
    next_pos = pos.zip(dir).map { _1.inject(:+) }
    x, y = next_pos

    if x < 0 || x >= width || y < 0 || y >= height
      return visited.map { _1[0] }.uniq
    end

    if grid[y] && grid[y][x] == ?#
      dir = [-dir[1], dir[0]]
    else
      pos = next_pos

      # cycle detection
      return if visited.include?([pos, dir])

      visited.add([pos, dir])
    end
  end
end

visited = travel(grid, pos)

puts visited.count

# Part 2
visited.shift

count = 0
visited.each do |(x, y)|
  grid[y][x] = ?#

  count += 1 unless travel(grid, pos)

  grid[y][x] = ?.
end

puts count
