#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

target = input.to_i
dimension = Math.sqrt(target).ceil

grid = Array.new(dimension) { Array.new(dimension) }
start = dimension / 2
x = y = start

dirs = [:right, :up, :left, :down]
dir = dirs[0]

def move(x, y, dir)
  case dir
  when :right
    x += 1
  when :up
    y -= 1
  when :left
    x -= 1
  when :down
    y += 1
  end

  [x, y]
end

(target - 1).times do |i|
  grid[y][x] = i + 1

  next_dir = dirs[(dirs.index(dir) + 1) % dirs.length]
  x1, y1 = move(x, y, next_dir)
  dir = next_dir if grid[y1][x1].nil?

  x, y = move(x, y, dir)
end

puts (x - start).abs + (y - start).abs
