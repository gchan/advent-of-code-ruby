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
    if position == 0
      count_zero += (distance / 100)
    elsif distance >= position
      count_zero += 1 + (distance - position) / 100
    end

    position -= distance
  when "R"
    count_zero += (position + distance) / 100

    position += distance
  end

  position %= 100
end

puts count_zero
