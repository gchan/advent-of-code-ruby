#!/usr/bin/env ruby

grid = [[], []]

prev_code = 20151125
grid[1][1] = prev_code

row = 1
col = 1

while !(row == 2978 && col == 3083)
  col += 1
  row -= 1

  if row == 0
    row = grid.length
    col = 1
    grid << []
  end

  code = (prev_code * 252533) % 33554393
  prev_code = code

  grid[row][col] = code
end

puts grid[row][col]
