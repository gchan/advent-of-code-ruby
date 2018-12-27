#!/usr/bin/env ruby

# Includes solution for part 2

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

clay_locations = input.split("\n").map do |clay|
  clay.split(", ")
end

x, y = clay_locations.flatten.partition { |clay| clay[0] == ?x }

xs = x.map { |x| x.scan(/\d+/) }.flatten.map(&:to_i)
ys = y.map { |x| x.scan(/\d+/) }.flatten.map(&:to_i)

x_min = xs.min - 1
x_max = xs.max + 1

y_min, y_max = ys.minmax

width = x_max - x_min + 1
height = y_max + 1

grid = Array.new(height) { Array.new(width, ?.) }

clay_locations.each do |from, to|
  range = Range.new(*to.scan(/\d+/).map(&:to_i))
  from_idx = from.scan(/\d+/)[0].to_i

  range.each do |idx|
    if from[0] == ?x
      grid[idx][from_idx - x_min] = ?#
    else
      grid[from_idx][idx - x_min] = ?#
    end
  end
end

def flow(grid, x, y)
  while grid[y + 1][x] == ?.
    y += 1
    grid[y][x] = ?|
    return if y + 1 == grid.length
    return if grid[y + 1][x] == ?|
  end

  left = x
  right = x

  # Rest water
  loop do
    # Find left/right clay or no bottom water/clay
    left = x

    while left > 0 && grid[y][left - 1].match(/[\.\|]/) && grid[y + 1][left - 1] != ?.
      left -= 1
    end

    right = x

    while right < grid[0].length && grid[y][right + 1].match(/[\.\|]/) && grid[y + 1][right + 1] != ?.
      right += 1
    end

    # No left and right clay
    break if grid[y][left - 1] == ?. || grid[y][right + 1] == ?.

    (left..right).each do |idx|
      grid[y][idx] = ?~
    end

    y -= 1
  end

  # Overflow
  (left..right).each do |idx|
    grid[y][idx] = ?|
  end

  # Overflow right
  if grid[y][right + 1] == ?.
    grid[y][right + 1] = ?|
    flow(grid, right + 1, y)
  end

  # Overflow left
  if grid[y][left - 1] == ?.
    grid[y][left - 1] = ?|
    flow(grid, left - 1, y)
  end
end

flow(grid, 500 - x_min, 0)

puts grid[y_min..-1].flatten.count { |cell| cell == ?| || cell == ?~ } # part 1
puts grid[y_min..-1].flatten.count { |cell| cell == ?~ } # part 2
