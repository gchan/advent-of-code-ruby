#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path).strip

height = 6
width = 25

area = height * width

layers = input.chars.map(&:to_i).each_slice(area)

area.times do |i|
  layer = layers.find do |layer|
    pixel = layer[i]
    pixel == 0 || pixel == 1
  end

  print (layer[i] == 0 ? " " : "#")
  puts if (i + 1) % width == 0
end
