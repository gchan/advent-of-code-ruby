#!/usr/bin/env ruby

# Also includes solution for part 2

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path).strip

map = input.split("\n").map do |line|
  line.split("")
end

asteroids = []
width = map.first.length
height = map.length

map.each.with_index do |row, y|
  row.each.with_index do |cell, x|
    asteroids << [x, y] if cell == "#"
  end
end

best = nil

asteroids.each do |x, y|
  angles = Hash.new { |h,k| h[k] = Array.new }

  asteroids.each do |x2, y2|
    next if y2 == y && x2 == x

    dx = x - x2
    dy = y - y2

    # atan2 returns angle in radians from the potisive x-axis plane
    # We want 0 to be on the positive y-axis hence minus PI / 2 radians
    # Modulo by PI * 2 radians to only deal with positive numbers
    angle = Math.atan2(dy, dx) - Math::PI / 2
    angle %= Math::PI * 2

    angles[angle] << [x2, y2]
  end

  if best.nil? || angles.count > best.count
    best = angles

    # Manhattan distance - vaporize closest first
    best.values.each do |asteroids|
      asteroids.sort_by! do |x3, y3|
        (x - x3).abs + (y - y3).abs
      end
    end
  end
end

puts best.count

vaporized = []

best.keys.sort.each do |angle|
  asteroid = best[angle].shift
  vaporized << asteroid

  if vaporized.count == 200
    puts asteroid[0] * 100 + asteroid[1]
    exit
  end
end
