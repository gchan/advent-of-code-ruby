#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

keys = [
  [nil, nil, 1,   nil, nil],
  [nil, 2,   3,   4,   nil],
  [5,   6,   7,   8,   9],
  [nil, 'A', 'B', 'C', nil],
  [nil, nil, 'D', nil, nil]
]

x = 0
y = 2

pin = ""

input.split("\n").each do |seq|
  seq.chars.each do |cmd|
    x2 = x
    y2 = y

    case cmd
    when 'U'
      y2 = [y - 1, 0].max
    when 'D'
      y2 = [y + 1, 4].min
    when 'L'
      x2 = [x - 1, 0].max
    when 'R'
      x2 = [x + 1, 4].min
    end

    if keys[y2][x2]
      x = x2
      y = y2
    end
  end

  pin << keys[y][x].to_s
end

puts pin
