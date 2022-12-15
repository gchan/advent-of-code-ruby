#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

sensors = {}
beacons = Set.new

input.strip.each_line do |sensor|
  sensor, beacon = sensor.split(":")

  x, y = sensor.scan(/\d+/).map(&:to_i)
  bx, by = beacon.scan(/-?\d+/).map(&:to_i)

  dist = (x - bx).abs + (y - by).abs

  sensors[[x,y]] = dist
  beacons << [bx, by]
end

row = 2_000_000

max_x = [sensors.keys.map(&:first).max, beacons.map(&:first).max].max

max_dist = sensors.values.max

count = 0

# Could be quicker by building ranges for each sensor, count
# the length and subtract any beacons and sensors on the row.
#
(-max_dist..max_x+max_dist).each do |x|
  print ?. if x % 100_000 == 0

  next if beacons.include?([x, row]) || sensors[[x, row]]

  sensors.each do |(sx, sy), dist|
    if (x - sx).abs + (row - sy).abs <= dist
      count += 1
      break
    end
  end
end

puts
puts count
