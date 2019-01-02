#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input = File.read(file_path)

depth, target = input.split("\n")

depth = depth.scan(/\d+/)[0].to_i
xt, yt = target.scan(/\d+/).map(&:to_i)

length = yt + 1
width = xt + 1

map = Array.new(length) { Array.new(width) }

map[0][0] = 0
map[yt][xt] = 0

length.times do |y|
  map[y][0] = (y * 48271 + depth) % 20183
end

width.times do |x|
  map[0][x] = (x * 16807 + depth) % 20183
end

length.times do |y|
  next if y == 0
  width.times do |x|
    next if x == 0 || x == xt && y == yt
    map[y][x] = ((map[y-1][x] * map[y][x-1]) + depth) % 20183
  end
end

length.times do |y|
  width.times do |x|
    map[y][x] %= 3
  end
end

puts map.flatten.inject(:+)
