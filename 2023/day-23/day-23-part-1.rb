#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.read(file_path)

require 'set'

$cache = {}

def distance(start, grid)
  return $cache[start] if $cache[start]

  curr = start

  w = grid.first.size
  h = grid.size

  goal = [grid.last.index(?.), h - 1]

  visited = [curr].to_set

  while curr != goal
    opts = [[0, 1], [1, 0], [-1, 0], [0, -1]]
      .map { |mod| mod.zip(curr).map(&:sum) }
      .reject { |x, y| x < 0 || y < 0 || x >= w || y >= h }
      .reject { visited.include?(_1) }
      .select { |x, y| grid[y][x] != ?# }
      .reject { |x, y| grid[y][x] == ?> && x < curr[0] }
      .reject { |x, y| grid[y][x] == ?v && y < curr[1] }
      .reject { |x, y| grid[curr[1]][curr[0]] == ?v && y < curr[1] }
      .reject { |x, y| grid[curr[1]][curr[0]] == ?> && x < curr[0] }

    if opts.count == 1
      curr = opts.first.clone
      visited << curr
    elsif opts.count > 1
      count = visited.count + opts.map { distance(_1.clone, grid) }.max
      $cache[start] = count

      return count
    end
  end

  $cache[start] = visited.count

  visited.count
end

grid = input.each_line.map { _1.strip.chars }

x = grid.first.index(?.)
y = 0

# Exclude starting position
pp distance([x, y], grid) - 1
