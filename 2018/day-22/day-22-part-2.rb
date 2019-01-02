#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input = File.read(file_path)

depth, target = input.split("\n")

depth = depth.scan(/\d+/)[0].to_i
xt, yt = target.scan(/\d+/).map(&:to_i)

length = yt + 1 + 15
width = xt + 1 + 15

map = Array.new(length) { Array.new(width) }

map[0][0] = 0
map[yt][xt] = 0

length.times do |y|
  map[y][0] = (y * 48271 + depth) % 20183
end

width.times do |x|
  map[0][x] = (x * 16807 + depth) % 20183
end

length.times do |y|
  next if y == 0
  width.times do |x|
    next if x == 0 || x == xt && y == yt
    map[y][x] = ((map[y-1][x] * map[y][x-1]) + depth) % 20183
  end
end

length.times do |y|
  width.times do |x|
    map[y][x] =
      case map[y][x] % 3
      when 0
        ?.
      when 1
        ?=
      when 2
        ?|
      end
  end
end

# BFS with a priority queue

equipment = {
  ?. => [:climb, :torch],
  ?= => [:climb, nil],
  ?| => [:torch, nil]
}

visited = {}
queue = [[0, 0, :torch, 0]]

while queue.any?
  queue.sort_by!(&:last)

  x, y, equip, time = queue.shift

  if x == xt && y == yt && equip == :torch
    puts time
    exit
  end

  adjacents = [[x, y - 1], [x - 1, y], [x + 1, y], [x, y + 1]]
    .reject { |x, y| x < 0 || y < 0 }
    .select { |x, y| x < width && y < length }

  adjacents.each do |x0, y0|
    tools = equipment[map[y0][x0]] & equipment[map[y][x]]

    t = time + 1
    e = equip

    if !tools.include?(equip)
      e = tools.first
      t += 7
    end

    if !visited[[x0, y0, e]] || visited[[x0, y0, e]] > t
      visited[[x0, y0, e]] = t

      queue << [x0, y0, e, t]
    end
  end
end
