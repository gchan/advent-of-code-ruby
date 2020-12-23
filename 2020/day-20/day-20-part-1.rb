#!/usr/bin/env ruby

# Includes solutions to both part 1 and 2

file_path = File.expand_path('day-20-input.txt', __dir__)
input     = File.read(file_path)

def rotate(tile)
  tile.transpose.map(&:reverse)
end

def flip(tile)
  tile.map(&:reverse)
end

def print(tile)
  tile.map(&:join).join("\n")
end

# N, E, S, W
def borders(tile)
  [
    tile.first,
    tile.transpose.last,
    tile.last,
    tile.transpose.first
  ]
end

tiles = {}

input.split("\n\n").each do |tile|
  id, tile = tile.match(/Tile (\d+):\n([\s\S]+)/).captures

  id = id.to_i
  tile = tile.split("\n").map(&:chars)

  tiles[id] = tile
end

neighbours = Hash.new { |h, k| h[k] = [] }

tiles.keys.combination(2) do |tile1, tile2|
  tile1_borders = borders(tiles[tile1])
  tile2_borders = borders(tiles[tile2]) + borders(tiles[tile2]).map(&:reverse)

  tile1_borders.each.with_index do |border1, idx|
    tile2_borders.each.with_index do |border2, idx2|
      if border1 == border2
        neighbours[tile1] << tile2
        neighbours[tile2] << tile1
      end
    end
  end
end

corners = neighbours.keys.select { |tile_id| neighbours[tile_id].count == 2 }

puts corners.inject(&:*)

# Part 2

size = (tiles.size)**(0.5)
image = Array.new(size) { Array.new(size, nil) }
image_ids = Array.new(size) { Array.new(size, nil) }

corner_id = corners.first
tile = tiles[corner_id]

# Smallest index of matching borders
border_idx = borders(tile).map.with_index { |border, idx|
  borders = neighbours[corner_id].flat_map { |id| borders(tiles[id]) }
  borders += borders.map(&:reverse)

  idx if borders.include?(border)
}.compact.min

# 1 == East
rotations = 1 - border_idx
rotations.times do
  tile = rotate(tile)
end

image[0][0] = tile
image_ids[0][0] = corner_id

#
# For the first row (y == 0), match tiles on left and right borders (east and
# west).
# For all other row, match tiles on top and bottom borders (north and south).
#
(0..size-1).each do |y|
  (0..size-1).each do |x|
    next if y == 0 && x == 0 # corner_id piece already placed

    # West neighbour if top row, else north neighbour
    if y == 0
      previous = image[y][x-1]
      previous_id = image_ids[y][x-1]
    else
      previous = image[y-1][x]
      previous_id = image_ids[y-1][x]
    end

    # East if top row, else south
    if y == 0
      border = borders(previous)[1]
    else
      border = borders(previous)[2]
    end

    tile_id = neighbours[previous_id].find do |id|
      tile = tiles[id]
      borders(tile).include?(border) ||
        borders(tile).map(&:reverse).include?(border)
    end

    tile = tiles[tile_id]

    # West if top row, else north
    if y == 0
      tile_dir = 3
    else
      tile_dir = 0
    end

    rotations = 0
    while borders(tile)[tile_dir] != border
      tile = rotate(tile)
      rotations += 1
      tile = flip(tile) if rotations == 4
    end

    image[y][x] = tile
    image_ids[y][x] = tile_id
  end
end

# Shave borders
image = image.map do |tiles_row|
  tiles_row.map do |tile|
    tile[1..-2].map { |row| row[1..-2] }
  end
end

# Connect tiles
image = image.flat_map do |tiles_row|
  tiles_row[0].zip(*tiles_row[1..-1]).map(&:flatten).map(&:join)
end

monster = [
  "                  # ",
  "#    ##    ##    ###",
  " #  #  #  #  #  #   "
]

monster_length = monster.first.size

monster_regexp = monster.map { |row|
  Regexp.new(row.gsub(" ", "."))
}

rotations = 0
monsters = 0

while monsters == 0
  (0..(image.size - 3)).each do |y|
    ((monster_length - 1)..(image.first.length)).each do |x|
      match = monster_regexp.each_with_index.all? { |regexp, idx|
        image[y + idx][x - monster_length, monster_length] =~ regexp
      }

      monsters += 1 if match
      x += 1
    end
  end

  rotations += 1
  image_chars = image.map(&:chars)

  image_chars = rotate(image_chars)
  image_chars = flip(image_chars) if rotations == 4
  image = image_chars.map(&:join)
end

monster_chars = monster.join.chars.count { |char| char == ?# }
puts image.join.chars.count { |char| char == ?# } - (monsters * monster_chars)
