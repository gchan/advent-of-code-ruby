#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

coords = []
folds = []

input.split("\n").each do |line|
  next if line.empty?

  if line.match?(/fold/)
    folds << line.scan(/(y|x)=(\d+)/).flatten
  else
    coords << line.split(",").map(&:to_i)
  end
end

height = coords.map(&:last).max + 1
width = coords.map(&:first).max + 1

grid = Array.new(height) { Array.new(width, ".") }

coords.each do |x, y|
  grid[y][x] = "#"
end

folds.each_with_index do |(axis, pos), idx|
  pos = pos.to_i

  grid = grid.transpose if axis == "x"

  # Fold downwards and account for uneven folds
  #
  grid = grid[0...pos].reverse.zip(grid[pos+1..]).map do |row_one, row_two|
    if row_one.nil? || row_two.nil?
      row_one || row_two
    else
      row_one.zip(row_two).map do |cell_one, cell_two|
        if cell_one == "#" || cell_two == "#"
          "#"
        else
          "."
        end
      end
    end
  end

  # Reverse the image as we should be folding upwards
  #
  grid = grid.reverse

  grid = grid.transpose if axis == "x"

  puts grid.flatten.count { |cell| cell == "#" } if idx == 0
end

puts grid.map(&:join).join("\n")
