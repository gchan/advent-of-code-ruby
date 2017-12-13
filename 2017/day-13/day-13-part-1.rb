#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

layers = {}

input.split("\n").each do |layer|
  depth, range = layer.split(':').map(&:to_i)
  layers[depth] = range
end

puts layers
  .map { |i, range| range * i if i % ((range - 1) * 2) == 0 }
  .compact
  .inject(:+)
