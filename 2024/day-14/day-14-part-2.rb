#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

width = 101
height = 103

robots = input.split(?\n)
  .map { _1.scan(/-*\d+/).map(&:to_i) }

seconds = 0

while true
  seconds += 1

  robots.each.with_index { |(x, y, vx, vy), idx|
    x = (x + vx) % width
    y = (y + vy) % height

    robots[idx][0] = x
    robots[idx][1] = y
  }

  grid = []

  height.times {
    grid << ?. * width
  }

  robots.each {
    grid[_2][_1] = ?#
  }

  grid = grid.join(?\n)

  if grid.include?("########")
    puts grid
    puts seconds
    exit
  end
end

