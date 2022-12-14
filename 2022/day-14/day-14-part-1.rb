#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

paths = input.split("\n").map do |path|
  path.split(" -> ").map { |point| point.split(",").map(&:to_i) }
end

min_x, max_x = paths.map { |path| path.map(&:first) }.flatten.minmax
max_y = paths.map { |path| path.map(&:last) }.flatten.max

width = max_x - min_x + 1
grid = Array.new(max_y + 1) { Array.new(width, ".") }

paths.each do |path|
  path.each_cons(2) do |(x, y), (x1, y1)|
    y1, y = y, y1 if y > y1
    x1, x = x, x1 if x > x1

    (y..y1).each do |y2|
      (x..x1).each do |x2|
        grid[y2][x2 - min_x] = "#"
      end
    end
  end
end

# puts grid.map(&:join).join("\n")

pour_x = 500 - min_x

1_000.times do |i|
  x = pour_x
  y = 0

  while true
    if grid[y + 1][x] == ?.
      y += 1
    elsif grid[y + 1][x - 1] == ?.
      y += 1
      x -= 1
    elsif grid[y + 1][x + 1] == ?.
      y += 1
      x += 1
    else
      break
    end

    if y == max_y
      # puts grid.map(&:join).join("\n")
      puts i
      exit
    end
  end

  grid[y][x] = "o"
end
