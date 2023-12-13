#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

DIRS = {
  n: [0, -1],
  s: [0, 1],
  w: [-1, 0],
  e: [1, 0]
}

PIPES = {
  '|': { n: :n, s: :s },
  '-': { w: :w, e: :e },
  'L': { w: :n, s: :e },
  'J': { s: :w, e: :n },
  '7': { n: :w, e: :s },
  'F': { w: :s, n: :e }
}

map = input.each_line.map { _1.strip.chars }

height = map.length
width = map.first.length

_, sy = map.each.with_index.find { |row, _| row.include?(?S) }
sx = map[sy].index(?S)

curr = [sx, sy]
dir = nil

path = []

DIRS.each do |direction, mod|
  x, y = curr.zip(mod).map(&:sum)

  next if x < 0 || y < 0 || x >= width || y >= height

  c = map[y][x].to_sym

  if PIPES[c][direction]
    dir = direction
    curr = [x, y]
    path << [curr, dir]
    break
  end
end

while map[curr[1]][curr[0]] != ?S
  c = map[curr[1]][curr[0]]
  dir = PIPES[c.to_sym][dir]
  mod = DIRS[dir]

  curr = curr.zip(mod).map(&:sum)

  path << [curr, dir]
end

puts path.count / 2
