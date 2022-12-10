#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.each_line.map { |line| line.strip.chars.map(&:to_i) }

width = grid.first.length
length = grid.length

trees = Hash.new { |hash, key| hash[key] = [] }

grid.each_with_index do |row, y|
  next if y == 0 || y == length - 1
  row.each_with_index do |height, x|
    next if x == 0 || x == width - 1

    # up
    dist = y
    (0..y-1).reverse_each.with_index do |y1, idx|
      if grid[y1][x] >= height
        dist = idx + 1
        break
      end
    end
    trees[[y, x]] << dist

    # left
    dist = x
    (0..x-1).reverse_each do |x1|
      if grid[y][x1] >= height
        dist = x - x1
        break
      end
    end
    trees[[y, x]] << dist

    # down
    dist = length - 1 - y
    (y+1..length-1).each do |y1|
      if grid[y1][x] >= height
        dist = y1 - y
        break
      end
    end
    trees[[y, x]] << dist

    # right
    dist = width - 1 - x
    (x+1..width-1).each do |x1|
      if grid[y][x1] >= height
        dist = x1 - x
        break
      end
    end
    trees[[y, x]] << dist
  end
end

puts trees.values.map { |dist| dist.inject(&:*) }.max
