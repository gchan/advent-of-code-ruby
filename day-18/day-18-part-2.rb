#!/usr/bin/env ruby

file_path  = File.expand_path("../day-18-input.txt", __FILE__)
input      = File.readlines(file_path)

grid = Array.new(100) { Array.new(100, false) }
broken_lights = [0, 99].product([0, 99])

input.each_with_index do |input, y|
  input.strip.chars.each_with_index do |state, x|
    grid[y][x] = state == '#'
  end
end

broken_lights.each do |x, y|
  grid[y][x] = true
end

def neighbours_on(grid, x, y)
  x_coords = [x - 1, x, x + 1].select { |x| x.between?(0, 99) }
  y_coords = [y - 1, y, y + 1].select { |y| y.between?(0, 99) }

  x_coords.product(y_coords).
    reject { |coords| coords == [x, y] }.
    count { |x, y| grid[y][x] }
end

100.times do
  new_grid = Array.new(100) { Array.new(100, false) }

  (0..99).to_a.product((0..99).to_a).each do |x, y|
    neighbours = neighbours_on(grid, x, y)

    if grid[y][x]
      new_grid[y][x] = neighbours.between?(2, 3)
    else
      new_grid[y][x] = neighbours == 3
    end

    new_grid[y][x] = true if broken_lights.include?([x, y])
  end

  grid = new_grid
end

puts grid.flatten.count { |state| state }
