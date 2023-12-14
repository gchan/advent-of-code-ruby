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

pipes = path.map(&:first).to_set

start_entry = path.last.last
start_exit = path.first.last
x, y = path.last.first

start_pipe = PIPES.keys.find {
  PIPES[_1][start_entry] == start_exit
}

map[y][x] = start_pipe.to_s

voids = width.times.to_a
  .product(height.times.to_a)
  .reject { |pos| pipes.include?(pos) }

# https://en.wikipedia.org/wiki/Even-odd_rule
voids
  .count { |x, y|
    crosses = 0

    # Cast a diagonal ray to the top left
    while x >= 0 && y >= 0
      if pipes.include?([x, y])
        c = map[y][x]

        # Ignore corners/vertexes
        if c != ?7 && c != ?L
          crosses += 1
        end
      end

      x -= 1
      y -= 1
    end

    crosses % 2 == 1
  }
  .tap { puts _1 }
