#!/usr/bin/env ruby

file_path = File.expand_path('day-11-input.txt', __dir__)
input     = File.read(file_path)

grid = input.split("\n").map(&:chars)

def neighbours(x, y, grid)
  [x - 1, x, x + 1].product([y - 1, y, y + 1])
    .reject { |x1, y1| x1 == x && y1 == y }
    .select { |x1, y1|
      (0..grid.size-1).cover?(y1) && (0..grid[0].size-1).cover?(x1)
    }
end

while true
  new_grid = grid.map(&:dup)

  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      next if cell == ?.

      occupied = neighbours(x, y, grid)
        .count { |x, y| grid[y][x] == ?# }

      case cell
      when ?L
        new_grid[y][x] = ?# if occupied.zero?
      when ?#
        new_grid[y][x] = ?L if occupied >= 4
      end
    end
  end

  #puts new_grid.map(&:join).join("\n")
  #puts

  if new_grid == grid
    puts new_grid.flatten.count { |c| c == ?# }
    exit
  end

  grid = new_grid.map(&:dup)
end
