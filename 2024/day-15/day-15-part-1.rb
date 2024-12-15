#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

grid, movements = input.split("\n\n")

pos = grid.split.join.index(?@)
grid = grid.split.map(&:chars)

height = grid.size
width = grid[0].size

y = pos / width
x = pos % width

movements.split.join.strip.chars.each do |dir|
  case dir
  when ?>
    x1, y1 = [x + 1, y]
  when ?<
    x1, y1 = [x - 1, y]
  when ?^
    x1, y1 = [x, y - 1]
  when ?v
    x1, y1 = [x, y + 1]
  end

  ## Debugging
  # puts grid.map(&:join).join("\n")
  # gets
  # puts dir

  # We see a block, go to next instruction
  next if grid[y1][x1] == ?#

  # Move if there is an open space
  if grid[y1][x1] == ?.
    grid[y1][x1] = ?@
    grid[y][x]   = ?.
    x, y = x1, y1

    next
  end

  # Identify whether there is space for the box(es)
  x2, y2 = x1, y1

  while grid[y2][x2] == ?O
    case dir
    when ?>
      x2, y2 = [x2 + 1, y2]
    when ?<
      x2, y2 = [x2 - 1, y2]
    when ?^
      x2, y2 = [x2, y2 - 1]
    when ?v
      x2, y2 = [x2, y2 + 1]
    end
  end

  # If there is a space for the boxes, move
  if grid[y2][x2] == ?.
    grid[y2][x2] = ?O

    grid[y1][x1] = ?@
    grid[y][x] = ?.
    x, y = x1, y1
  end
end

# puts grid.map(&:join).join("\n")

sum = 0

grid.each.with_index do |row, y|
  row.each.with_index do |cell, x|
    sum += (y * 100 + x) if cell == ?O
  end
end

puts sum
