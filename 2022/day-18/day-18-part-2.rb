#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

cubes = Set.new

input.strip.split("\n").map do |cube|
  cubes << cube.split(",").map(&:to_i)
end

x_max = cubes.map { |cube| cube[0] }.max + 1
y_max = cubes.map { |cube| cube[1] }.max + 1
z_max = cubes.map { |cube| cube[2] }.max + 1

visited = Set.new
queue = [[0, 0, 0]]

count = 0

while queue.any?
  pos = queue.shift

  neighbours = [-1, 1].product([0, 1, 2]).map do |move, d|
    neighbour = pos.clone
    neighbour[d] += move

    x, y, z = neighbour

    next if visited.include?(neighbour)
    next if x < -1 || y < -1 || z < -1 ||
      x > x_max || y > y_max || z > z_max

    if cubes.include?(neighbour)
      count += 1
    else
      queue << neighbour
      visited << neighbour
    end
  end
end

puts count
