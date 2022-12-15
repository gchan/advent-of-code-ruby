#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

sensors = {}

input.strip.each_line do |sensor|
  sensor, beacon = sensor.split(":")

  x, y = sensor.scan(/\d+/).map(&:to_i)
  bx, by = beacon.scan(/-?\d+/).map(&:to_i)

  dist = (x - bx).abs + (y - by).abs

  sensors[[x,y]] = dist
end

# Enumerate through each sensor and build ranges for each row.
#
# However it rould be more efficient to enumerate through
# each row, build the ranges and check as we go. That way we
# can discard row ranges and avoid build ranges that we may
# not need.
#
rows = Hash.new { |h, k| h[k] = [] }

max = 4_000_000

sensors.each do |(x, y), dist|
  print ?.

  x1 = x - dist
  x2 = x + dist

  (dist + 1).times do |i|
    range = [x1 + i, x2 - i]

    # Not cloning here cost me a lot of debugging time!
    rows[y + i] << range.clone
    rows[y - i] << range.clone
  end
end

puts

(max + 1).times.each do |y|
  print ?. if y % 100_000 == 0

  ranges = rows[y].sort

  range = ranges.shift

  ranges.each do |(from, to)|
    if from <= range[1]
      range[1] = [range[1], to].max
    else
      x = from - 1

      puts
      puts [x, y].inspect
      puts x * 4000000 + y
      exit
    end
  end
end
