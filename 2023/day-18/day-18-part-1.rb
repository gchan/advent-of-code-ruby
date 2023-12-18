#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

DIRS = {
  U: [0, -1],
  D: [0, 1],
  L: [-1, 0],
  R: [1, 0]
}

pos = [0, 0]
dug = [pos]

input.each_line {
  dir, dis, _ = _1.split
  dis = dis.to_i

  dis.times {
    pos = DIRS[dir.to_sym].zip(pos).map(&:sum)

    dug << pos
  }
}

min_x = dug.map(&:first).min
max_x = dug.map(&:first).max
min_y = dug.map(&:last).min
max_y = dug.map(&:last).max

width = max_x - min_x + 1
height = max_y - min_y + 1

grid = []

height.times {
  grid << Array.new(width, ".")
}

dug.each do |x ,y|
  x1 = x - min_x
  y1 = y - min_y

  grid[y1][x1] = ?#
end

require 'set'
empty = Set.new

# Find external area and flood fill
width.times.each do |x|
  if grid[0][x] == ?.
    empty << [x, 0]
  end

  if grid[height-1][x] == ?.
    empty << [x, height-1]
  end
end

height.times.each do  |y|
  if grid[y][0] == ?.
    empty << [0, y]
  end

  if grid[y][width-1] == ?.
    empty << [width-1, y]
  end
end

queue = empty.to_a

while queue.any?
  x, y = queue.pop

  [[0, -1], [0, 1], [-1, 0], [1, 0]].each do |move|
    x1, y1 = move.zip([x,y]).map(&:sum)

    next if x1 < 0 || x1 >= width || y1 < 0 || y1 >= height
    next if grid[y1][x1] == ?#
    next if empty.include?([x1, y1])

    queue << [x1, y1]
    empty << [x1, y1]
  end
end

pp (width * height) - empty.count
