#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input = File.read(file_path)

map, instructions = input.split("\n\n")

instructions = instructions.scan(/\d+|[A-z]+/)

rows = map.split("\n")
width = rows.map(&:size).max
height = rows.size

grid = rows
  .map { _1.ljust(width, " ") }
  .map(&:chars)

y = 0
x = grid.first.index(".")
dir = [1, 0]

instructions.each do
  case _1
  when "L"
    dir = [dir[1], -dir[0]]
  when "R"
    dir = [-dir[1], dir[0]]
  else # number
    _1.to_i.times {
      x1, y1 = [x, y].zip(dir).map(&:sum)

      x1 %= width
      y1 %= height

      while grid[y1][x1] == " "
        x1, y1 = [x1, y1].zip(dir).map(&:sum)

        x1 %= width
        y1 %= height
      end

      break if grid[y1][x1] == "#"

      x, y = x1, y1
    }
  end
end

puts (y + 1) * 1000 +
  (x + 1) * 4 +
  [[1, 0], [0, 1], [-1, 0], [0, -1]].index(dir)
