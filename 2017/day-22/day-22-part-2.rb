#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input = File.read(file_path)

grid = input.split("\n").map(&:chars)

x = y = grid.size / 2
dir = :up

dirs = [:up, :right, :down, :left]
count = 0

10_000_000.times do |i|
  case grid[y][x]
  when'#'
    dir = dirs[(dirs.index(dir) + 1) % 4]
    grid[y][x] = "F"
  when "."
    dir = dirs[(dirs.index(dir) - 1) % 4]
    grid[y][x] = "W"
  when 'F'
    dir = dirs[(dirs.index(dir) + 2) % 4]
    grid[y][x] = "."
  when "W"
    grid[y][x] = "#"
    count += 1
  end

  case dir
  when :left
    x -= 1
  when :up
    y -= 1
  when :down
    y += 1
  when :right
    x += 1
  end

  if y < 0
    grid.unshift(['.'] * grid.first.size)
    y += 1
  elsif x < 0
    grid.each { |row| row.unshift "." }
    x += 1
  elsif y >= grid.size
    grid.push(['.'] * grid.first.size)
  elsif x >= grid.first.size
    grid.each { |row| row.push "." }
  end
end

puts count
