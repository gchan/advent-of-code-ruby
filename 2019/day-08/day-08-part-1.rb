#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path).strip

height = 6
width = 25

area = height * width

layers = input.chars.map(&:to_i).each_slice(area)

layer = layers.min_by do |layer|
  layer.count { |pixel| pixel.zero? }
end

puts layer.count { |pixel| pixel == 1 } *
  layer.count { |pixel| pixel == 2 }
