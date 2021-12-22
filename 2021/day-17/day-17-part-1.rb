#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

x1, x2, y1, y2 = input.scan(/x=([-\d]*)..([-\d]*), y=([-\d]*)..([-\d]*)/)
  .flatten.map(&:to_i)

max_v = nil

(y1..500).each do |yv|
  vel = yv
  current = yv
  step = 1

  while true
    if (y1..y2).cover?(current)
      max_v = yv
      break
    end

    vel -= 1
    current += vel
    step += 1

    break if current < y1
  end
end

vel = max_v

max_y = 0

while vel > 0
  max_y += vel
  vel -= 1
end

puts max_y
