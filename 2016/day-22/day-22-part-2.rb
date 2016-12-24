#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")[2..-1]

cols, rows = lines.last.match(/x(\d+)-y(\d+)/)[1..-1].map(&:to_i)
cols += 1
rows += 1

Node = Struct.new(:x, :y, :size, :used, :avail)

nodes = Array.new(rows) { Array.new(cols) }

empty_node = nil

lines.each do |line|
  x, y, size, used, avail = line.match(/x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T\s*(\d+)T/)[1..-1].map(&:to_i)

  node = Node.new(x, y, size, used, avail)
  empty_node = node if node.used == 0
  nodes[y][x] = node
end

nodes.length.times do |y|
  nodes[y].length.times do |x|
    node = nodes[y][x]

    if x == cols - 1 && y == 0
      print "G"
    elsif node.used > 100
      print "#"
    elsif node.used == 0
      print '_'
    else
      print '.'
    end
  end
  puts
end

# Move to the top (y=0)
visited = Set.new
queue = [[empty_node, 0]]

visited.add(queue.first[0..1])
reached_goal = false

while !reached_goal
  current, step = queue.shift

  if current.y == 0
    reached_goal = true
    next
  end

  x = current.x
  y = current.y

  [[x+1, y], [x-1, y], [x, y+1], [x, y-1]].each do |x, y|
    next if x < 0 || y < 0 || x >= nodes[0].size || y >= nodes.size
    next if nodes[y][x].used > current.size
    next if visited.include?([x, y])

    visited.add([x, y])
    new_location = [nodes[y][x], step + 1]
    queue << new_location
  end
end

total_steps = step
current_x = current.x

# Move to the right of goal node
total_steps += cols - current_x - 1

# Down, 3 Left, Up, Right (5 Moves)
total_steps += 5 * (cols - 2)

puts total_steps
