#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

keys = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

x = 1
y = 1

pin = ""

input.split("\n").each do |seq|
  seq.chars.each do |cmd|
    case cmd
    when 'U'
      y = [y - 1, 0].max
    when 'D'
      y = [y + 1, 2].min
    when 'L'
      x = [x - 1, 0].max
    when 'R'
      x = [x + 1, 2].min
    end
  end

  pin << keys[y][x].to_s
end

puts pin
