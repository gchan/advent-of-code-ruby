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
queue << [0, start, dir, [[start, dir]]]

from = Hash.new { |h, k| h[k] = [] }
good_path = Set.new

enqueue = -> (score, loc, dir, p_loc, p_dir, path) {
  if visited[[loc, dir]] > score
    visited[[loc, dir]] = score

    # We found a better path to this node, remove any previous children
    from[[loc, dir]] = [[p_loc, p_dir]]

    queue.unshift([score, loc, dir, path.clone << [loc, dir]])
  elsif visited[[loc, dir]] == score
    from[[loc, dir]] << [p_loc, p_dir]
  end
}

goal = []
while queue.any?
  score, loc, dir, path = queue.shift

  # Move forward
  loc2 = loc.zip(dir).map { _1.inject(:+) }
  x1, y1 = loc2

  case grid[y1][x1]
  when ?E
    puts score + 1

    goal = [loc2, dir]
    path << [loc2, dir]

    path.each { good_path.add(_1) }
    next
  when ?.
    enqueue.call(score + 1, loc2, dir, loc, dir, path)
  end

  # Left turn
  enqueue.call(
    score + 1000,
    loc, [dir[1], -dir[0]],
    loc, dir,
    path
  )

  # Right turn
  dir2 = [-dir[1], dir[0]]
  enqueue.call(
    score + 1000,
    loc, dir2,
    loc, dir,
    path
  )

  queue.sort_by!(&:first)
end

queue = good_path.to_a

while queue.any?
  loc, dir = queue.pop

  from[[loc, dir]].each do |l2, d2|
    next if good_path.include?([l2,d2])

    queue << [l2, d2]
    good_path << [l2, d2]
  end
end

p good_path.map(&:first).uniq.count

## Debugging
# good_path.map(&:first).uniq.each {
#   grid[_2][_1] = ?O
# }
#
# puts grid.map(&:join).join("\n")
