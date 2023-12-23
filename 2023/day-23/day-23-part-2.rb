#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.read(file_path)

require 'set'

grid = input.each_line.map { _1.strip.chars }

x = grid.first.index(?.)
y = 0

w = grid.first.size
h = grid.size

goal = [grid.last.index(?.), h - 1]

graph = Hash.new { |h, k| h[k] = {} }

queue = [[[x,y], [x,y]]]

while queue.any?
  pos, origin = queue.shift

  visited = [pos].to_set

  until graph[origin][pos]
    opts = [[0, 1], [1, 0], [-1, 0], [0, -1]]
      .map { |mod| mod.zip(pos).map(&:sum) }
      .reject { |x, y| x < 0 || y < 0 || x >= w || y >= h }
      .select { |x, y| grid[y][x] != ?# }
      .reject { visited.include?(_1) }
      .reject { _1 == origin }

    # Only one direction - keep moving
    if opts.count == 1
      pos = opts.first.clone

      visited << pos
    # Found an intersection or reached the goal (no where left to go)
    elsif opts.count > 1 || opts.empty?
      opts.each { |opt| queue << [opt, pos] }

      graph[origin][pos] = visited.count
      graph[pos][origin] = visited.count
    end
  end
end


$max = 0

def dfs(pos, graph, goal, seen = Set.new)
  return 0 if pos == goal

  # Return a negative number if we can't find a solution where
  # we end on the goal square
  max = -100_000

  # Prevent revisiting existing nodes
  seen << pos

  graph[pos].each do |node, dist|
    next if seen.include?(node)

    max = [
      max,
      dfs(node, graph, goal, seen) + dist
    ].max

    if max > $max
      puts max
      $max = max
    end
  end

  # So other DFS calls can visit this node
  seen.delete(pos)

  max
end

# This takes ~ 1 min to run
# We subtract one to remove the starting square
pp dfs([x,y], graph, goal) - 1
