#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

grid = Array.new(1000) { Array.new(1000, 0) }

claims = input.split("\n")

claims.each do |claim|
  ord, dim = claim.split("@").last.split(":")
  x, y = ord.split(",").map(&:to_i)
  w, h = dim.split("x").map(&:to_i)

  w.times do |x1|
    h.times do |y1|
      grid[x + x1][y + y1] += 1
    end
  end
end

puts grid.flatten.select { |cell| cell > 1 }.count
