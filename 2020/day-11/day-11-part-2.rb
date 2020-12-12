#!/usr/bin/env ruby

file_path = File.expand_path('day-11-input.txt', __dir__)
input     = File.read(file_path)

grid = input.split("\n").map(&:chars)

def visible(x, y, grid)
  [-1, 0, 1].product([-1, 0, 1])
    .reject { |dx, dy| dx == 0 && dy == 0 }
    .map { |dx, dy|
      x1 = x + dx
      y1 = y + dy

      while grid.dig(y1, x1) == ?.
        x1 += dx
        y1 += dy
      end

      [x1, y1]
    }
    .select { |x, y|
      (0..grid.size-1).cover?(y) && (0..grid[0].size-1).cover?(x)
    }
end

while true
  new_grid = grid.map(&:dup)

  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      next if cell == ?.

      visible_count = visible(x, y, grid)
        .count { |x, y| grid[y][x] == ?# }

      case cell
      when ?L
        new_grid[y][x] = ?# if visible_count == 0
      when ?#
        new_grid[y][x] = ?L if visible_count >= 5
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
