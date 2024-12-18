#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split.join.chars

height = input.split.size
width =  input.split.first.size

antennas = Hash.new { |h, k| h[k] = Set.new }

grid.each.with_index
  .reject { _1[0] == ?. }
  .each { antennas[_1].add([_2 % width, _2 / width]) }

antinodes = Set.new

def add(antinodes, location, vector, width, height)
  while true
    location = location.zip(vector).map { _1.inject(&:-) }

    x, y = location

    return if x < 0 || y < 0 || x >= width || y >= height

    antinodes.add(location)
  end
end

antennas.each do |_type, locations|
  locations.to_a.combination(2).each do |loc1, loc2|
    vector = loc1.zip(loc2).map { _1.inject(&:-) }

    add(antinodes, loc1, vector, width, height)
    add(antinodes, loc2, vector.map { _1 * -1 }, width, height)
  end
end

puts antinodes.count
