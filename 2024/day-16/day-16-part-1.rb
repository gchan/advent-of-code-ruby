#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split.map(&:chars)

width = grid[0].size
height = grid.size

start = input.split.join.index(?S)
start = [start % width, start / height]

# East
dir = [1, 0]

visited = {}
visited.default = 100_000_000

queue = []
queue << [0, start, dir]

enqueue = -> (score, loc, dir) {
  next if visited[[loc, dir]] <= score

  queue.unshift([score, loc, dir])
  visited[[loc, dir]] = score
}

while queue.any?
  queue.sort_by!(&:first)
  score, loc, dir = queue.shift

  # Move forward
  loc2 = loc.zip(dir).map { _1.inject(:+) }
  x, y = loc2

  case grid[y][x]
  when ?E
    puts score + 1
    exit
  when ?.
    enqueue.call(score + 1, loc2, dir)
  end

  # Left turn
  enqueue.call(score + 1000, loc, [dir[1], -dir[0]])

  # Right turn
  enqueue.call(score + 1000, loc, [-dir[1], dir[0]])
end
