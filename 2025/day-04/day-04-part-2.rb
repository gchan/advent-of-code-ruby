#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split("\n").map.map(&:chars)

to_remove = []
removed_count = 0
stop = false

while !stop
  grid.each_with_index do |row, x|
    row.each_with_index do |char, y|
      next if char == ?.

      neighbours = 0
      (x - 1..x + 1).each do |r|
        (y - 1..y + 1).each do |c|
          next if r == x && c == y
          next if r < 0 || r >= grid.length
          next if c < 0 || c >= grid[0].length

          neighbours += 1 if grid[r][c] != ?.
        end
      end

      to_remove << [x, y] if neighbours < 4
    end
  end

  to_remove.each do |x, y|
    grid[x][y] = ?.
  end

  removed_count += to_remove.length
  stop = to_remove.empty?
  to_remove = []
end

puts removed_count
