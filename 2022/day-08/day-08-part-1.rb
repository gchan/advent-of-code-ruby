#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.each_line.map { |line| line.strip.chars.map(&:to_i) }

trees = Set.new

max = -1
proc = Proc.new do |height, x, y|
  next if height <= max
  trees << [y, x]
  max = height
end

grid.each_with_index do |row, y|
  max = -1
  row.each_with_index do |height, x|
    proc.call(height, x, y)
  end

  max = -1
  row.each_with_index.reverse_each do |height, x|
    proc.call(height, x, y)
  end
end

grid.transpose.each_with_index do |col, x|
  max = -1
  col.each_with_index do |height, y|
    proc.call(height, x, y)
  end

  max = -1
  col.each_with_index.reverse_each do |height, y|
    proc.call(height, x, y)
  end
end

puts trees.count
