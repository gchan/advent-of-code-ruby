#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

cubes = Set.new

input.strip.split("\n").map do |cube|
  cubes << cube.split(",").map(&:to_i)
end

count = 0

cubes.each do |pos|
  neighbours = [-1, 1].product([0, 1, 2]).map do |v, i|
    neighbour = pos.clone
    neighbour[i] += v

    count += 1 if cubes.include?(neighbour)
  end
end

puts cubes.count * 6 - count
