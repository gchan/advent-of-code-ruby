#!/usr/bin/env ruby

# Includes solutions to both part 1 and 2
#
file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n").map(&:chars)

ins = lines.map do |chars|
  dirs = []

  while chars.any?
    dir = chars.shift
    dir += chars.shift if dir == ?s || dir == ?n
    dirs << dir
  end

  dirs
end

map = {}
ins.each do |inst|
  x, y  = 0,0

  inst.each do |i|
    case i
    when ?e
      x += 1
    when ?w
      x -= 1
    when 'se'
      y += 1
    when 'sw'
      x -= 1
      y += 1
    when 'ne'
      x += 1
      y -= 1
    when 'nw'
      y -= 1
    else
      raise 'e'
    end
  end

  map[[x,y]] = !map[[x,y]]
end

puts map.values.count { |black| black }

# Part 2
#
def neighbours(x, y)
  [[x-1, y], [x+1, y], [x, y+1], [x, y-1], [x-1, y+1], [x+1, y-1]]
end

100.times do
  map.keys.each do |loc|
    next unless map[loc]
    neighbours(*loc).each do |loc2|
      map[loc2] = false unless map[loc2]
    end
  end

  updates = {}

  map.each do |loc, black|
    count = neighbours(*loc).count { |loc2| map[loc2] }

    if black
      if count == 0 || count > 2
        updates[loc] = false
      end
    elsif count == 2
      updates[loc] = true
    end
  end

  updates.each do |loc, black|
    map[loc] = black
  end
end

puts map.values.count { |black| black }
