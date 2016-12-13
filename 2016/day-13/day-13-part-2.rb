#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

maze = Array.new(50) { Array.new }

xy = (0..50).to_a

xy.product(xy).each do |x, y|
  sum = x*x + 3*x + 2*x*y + y + y*y + input.to_i
  wall = sum.to_s(2).gsub("0", "").length.odd?

  maze[x][y] = wall ? "#" : "."
end

# puts maze.map(&:join).join("\n")

locations = Set.new
queue = [[1, 1, 0]]

while queue.any?
  current = queue.shift

  locations.add(current[0..1])

  x = current[0]
  y = current[1]
  step = current[2]

  next if step == 50

  next_locations = [[x+1, y], [x-1, y], [x, y+1], [x, y-1]]

  next_locations.each do |x, y|
    next if x < 0 || y < 0
    next if maze[x][y] == "#"
    next if locations.include?([x, y])

    queue << [x, y, step + 1]
  end
end

puts locations.count
