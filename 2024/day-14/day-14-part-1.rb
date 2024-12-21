#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

width = 101
height = 103
iter = 100

robots = input.split(?\n)

locations = robots.map { |robot|
  x, y, vx, vy = robot.scan(/-*\d+/).map(&:to_i)

  iter.times {
    x = (x + vx) % width
    y = (y + vy) % height
  }

  [x, y]
}

my = height / 2
mx = width / 2

x = [0...mx, (mx + 1)...width]
y = [0...my, (my + 1)...height]

quadrants = x.product(y)
count = [0, 0, 0, 0]

locations.each do |x, y|
  idx = quadrants.find_index { |x1, y1|
    x1.cover?(x) && y1.cover?(y)
  }

  count[idx] += 1 if idx
end

p count.inject(:*)
