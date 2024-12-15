#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

grid, movements = input.split("\n\n")

grid = grid
  .gsub(?#, "##")
  .gsub(?O, "[]")
  .gsub(?., "..")
  .gsub(?@, "@.")

pos = grid.split.join.index(?@)
grid = grid.split.map(&:chars)

# puts grid.map(&:join).join("\n")

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

  # We see a box, see if we can push them
  #
  # Moving boxes left and right is easy
  if dir == ?> || dir == ?<
    x2, y2 = x1, y1

    while grid[y2][x2] == ?[ || grid[y2][x2] == ?]
      case dir
      when ?>
        x2, y2 = [x2 + 1, y2]
      when ?<
        x2, y2 = [x2 - 1, y2]
      end
    end

    # If there is a space to the left/right for the box(es), move them
    if grid[y2][x2] == ?.
      from, to = x1 + 1, x2
      from, to = to, from if from > to

      (from..to).each.with_index {
        grid[y][_1] = _2.even? ? ?[ : ?]
      }

      grid[y1][x1] = ?@
      grid[y][x] = ?.

      x, y = x1, y1
    end
  else # Moving boxes up or down is more difficult
    # Track connected boxes by their left-side position
    boxes = []

    if grid[y1][x1] == ?]
      boxes << [x1 - 1, y1]
    else
      boxes << [x1, y1]
    end

    # Assume we can push boxes until we see a block
    movable = true

    # Find all connected boxes
    queue = boxes.dup
    queue << boxes[0].dup.tap { _1[0] += 1 }

    while queue.any?
      bx, by = queue.pop
      by += (dir == ?^ ? -1 : 1 )

      if grid[by][bx] == ?[ || grid[by][bx] == ?]
        if grid[by][bx] == ?]
          boxes << [bx - 1, by]
        else
          boxes << [bx, by]
        end

        queue << boxes.last
        queue << boxes.last.dup.tap { _1[0] += 1 }

      elsif grid[by][bx] == ?#
        movable = false
        queue.clear
      end
    end

    if movable
      # Clear the grid cells
      boxes.each { |bx, by|
        grid[by][bx] = ?.
        grid[by][bx + 1] = ?.
      }

      # Paint the new box locations
      boxes.each { |bx, by|
        by += (dir == ?^ ? -1 : 1 )

        grid[by][bx] = ?[
        grid[by][bx + 1] = ?]
      }

      grid[y1][x1] = ?@
      grid[y][x] = ?.

      x, y = x1, y1
    end
  end
end

# puts grid.map(&:join).join("\n")

sum = 0

grid.each.with_index do |row, y|
  row.each.with_index do |cell, x|
    sum += (y * 100 + x) if cell == ?[
  end
end

puts sum
