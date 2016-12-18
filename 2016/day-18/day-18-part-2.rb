#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

rows = 400_000
count = 0

current_row = input.chars.map do |char|
  if char == '^'
    1
  else
    count += 1
    0
  end
end

row_length = current_row.length

(rows - 1).times do
  prev_row = current_row
  current_row = []

  row_length.times do |col|
    left   = col > 0 ? prev_row[col - 1] : 0
    center = prev_row[col]
    right  = prev_row[col + 1] || 0

    tile = left ^ center ^ right ^ center

    count += 1 if tile == 0
    current_row << tile
  end
end

puts count
