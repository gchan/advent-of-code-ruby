#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

serial = input.to_i

def power(x, y, serial)
  id = x + 10
  power = id * y
  power += serial
  power *= id
  hundredth = (power / 100) % 10
  hundredth - 5
end

grid = Array.new(300) { Array.new(300, 0) }

300.times do |x|
  300.times do |y|
    grid[x][y] = power(x, y, serial)
  end
end

max = max_x = max_y = nil

297.times do |x|
  297.times do |y|
    sum = 0

    3.times do |x1|
      3.times do |y1|
        sum += grid[x+x1][y+y1]
      end
    end

    if max.nil? || sum > max
      max = sum
      max_x = x
      max_y = y
    end
  end
end

puts [max_x, max_y].inspect
