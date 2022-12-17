#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

jets = input.strip.chars

rocks = "####

.#.
###
.#.

..#
..#
###

#
#
#
#

##
##
"

rocks = rocks.split("\n\n").map do |rock|
  rock.split("\n").map(&:chars)
end

CHAMBER_WIDTH = 7
MAX_ROCK_HEIGHT = rocks.map(&:length).max
X_OFFSET = 2
Y_OFFSET = 4

grid = Array.new(5) { Array.new(CHAMBER_WIDTH, " ") }

def can_move?(rock, grid, x, y)
  h = rock.length
  w = rock.first.length

  return false if y >= grid.length
  return false if x < 0 || x + w > grid[0].length

  rock.each_with_index do |row, y1|
    row.each_with_index do |cell, x1|
      if cell == "#" && grid[y - h + 1 + y1][x + x1] == "#"
        return false
      end
    end
  end

  true
end

tower_height = 0
jet_idx = 0

2022.times do |i|
  rock = rocks[i % rocks.length]

  rock_height = rock.length

  x = X_OFFSET
  y = grid.length - tower_height - Y_OFFSET

  while true
    move = jets[jet_idx]
    jet_idx = (jet_idx + 1) % jets.length

    case move
    when ?<
      x -= 1 if can_move?(rock, grid, x - 1, y)
    when ?>
      x += 1 if can_move?(rock, grid, x + 1, y)
    end

    if can_move?(rock, grid, x, y + 1)
      y += 1
    else
      rock.each_with_index do |row, y1|
        row.each_with_index do |cell, x1|
          next if cell == ?.

          y2 = y - (rock_height - 1) + y1
          grid[y2][x + x1] = cell
        end
      end

      tower_height = [
        grid.length - y + (rock_height - 1),
        tower_height
      ].max

      break
    end
  end

  (Y_OFFSET + MAX_ROCK_HEIGHT - 1 - (grid.length - tower_height)).times do
    grid.unshift(Array.new(CHAMBER_WIDTH, " "))
  end
end

puts tower_height

# puts grid.first(20).map(&:join).join("\n")
