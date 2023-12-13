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

pipes = path.map(&:first).to_set

voids = width.times.to_a
  .product(height.times.to_a)
  .reject { |pos| pipes.include?(pos) }
  .to_set

def neighbours(x, y, height, width)
  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ]
    .reject { |x, y| x < 0 || y < 0 }
    .reject { |x, y| x >= width }
    .reject { |x, y| y >= height }
end


# Map position to a group of connected voids
candidates = {}
groups = []

voids.each { |pos|
  next if candidates[pos]

  group = Set.new([pos])
  candidates[pos] = group
  groups << group

  to_visit = [pos]
  while to_visit.any?
    pos = to_visit.pop

    neighbours(*pos, height, width)
      .select { voids.include?(_1) }
      .reject { candidates[_1] }
      .each { |pos|
        group << pos
        candidates[pos] = group
        to_visit << pos
      }
  end
}

# Identify the cells belonging to a group on a border
outside = groups
  .select { |group|
    group.any? { |x, y| x == 0 || x == width - 1 || y == 0 || y == height - 1 }
  }
  .flat_map(&:to_a)
  .to_set

RIGHT = {
  n: :e,
  s: :w,
  e: :s,
  w: :n
}

LEFT = {
  n: :w,
  s: :e,
  e: :n,
  w: :s
}

def right(dir, pos)
  RIGHT[dir]
    .then { DIRS[_1] }
    .zip(pos)
    .map(&:sum)
end

def left(dir, pos)
  LEFT[dir]
    .then { DIRS[_1] }
    .zip(pos)
    .map(&:sum)
end

# Determine which direction (from the pipe's perspective), is facing inside
inside_dir = path.lazy
  .map { |pos, dir|
    if left(dir, pos).then { outside.include?(_1) }
      :right
    elsif right(dir, pos).then { outside.include?(_1) }
      :left
    end
  }
  .compact
  .first

surrounding = Set.new

path.each_cons(2) do |(pos, curr_dir), (_, next_dir)|
  [curr_dir, next_dir].uniq.each do |dir|
    send(inside_dir, dir, pos)
      .then { candidates[_1] }
      &.tap { surrounding.merge(_1) }
  end
end

puts surrounding.count
