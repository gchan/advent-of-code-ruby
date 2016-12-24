#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

maze = input.split("\n").map { |line| line.chars }

targets = {}

maze.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    targets[cell] = [x, y] if cell =~ /\d/
  end
end

distances = Hash.new { |h, k| h[k] = {} }

(targets.to_a).product(targets.to_a).each do |(s, (sx, sy)), (g, (gx, gy))|
  next if s == g || distances[s][g]

  visited = Set.new
  queue = [[sx, sy, 0]]

  visited.add(queue.first[0..1])
  reached_goal = false

  while !reached_goal
    current = queue.shift

    if current[0..1] == [gx, gy]
      distances[s][g] = current[2]
      distances[g][s] = current[2]

      reached_goal = true
    end

    x = current[0]
    y = current[1]
    step = current[2]

    [[x+1, y], [x-1, y], [x, y+1], [x, y-1]].each do |x, y|
      next if x < 0 || y < 0
      next if maze[y][x] == "#"
      next if visited.include?([x, y])

      visited.add([x, y])
      new_location = [x, y, step + 1]
      queue << new_location
    end
  end
end

lowest = 1_000

(1..7).map(&:to_s).permutation.each do |sequence|
  sequence.unshift("0")

  sum = sequence.each_cons(2).
    map { |start, goal| distances[start][goal] }.
    inject(:+)

  lowest = [lowest, sum].min
end

puts lowest
