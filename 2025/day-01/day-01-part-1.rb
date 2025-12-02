#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

rotations = input.split("\n")

position = 50
count_zero = 0

rotations.each do |rotation|
  direction, distance = rotation.scan(/[LR]+|\d+/)
  distance = distance.to_i

  case direction
  when "L"
    position -= distance
  when "R"
    position += distance
  end

  position %= 100
  count_zero += 1 if position == 0
end

puts count_zero
