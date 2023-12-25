#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input     = File.read(file_path)

require 'set'

graph = Hash.new { |h, k| h[k] = [] }

input.each_line.each {
  from, to = _1.strip.split(?:)

  to.split.each { |other|
    graph[from] << other
    graph[other] << from
  }
}

def dfs(from, goal, graph)
  queue = graph[from].map { |to| [from, to] }

  while queue.any?
    path = queue.shift
    curr = path.last

    return path if curr == goal

    graph[curr].each do |to|
      next if path.include?(to)

      queue << (path.clone << to)
    end
  end

  raise
end

nodes = graph.keys

edge_counts = Hash.new(0)

# Sample 150 node pairs and tally the edges (node pairs) in the path
# It is possible to sample less than 150
#
# Note this doesn't work on the sample input, replace with
# nodes.combination(2).each ...
nodes.shuffle.first(150).zip(nodes.shuffle.first(150)).each do |from, to|
  next if from == to

  dfs(from, to, graph).each_cons(2).to_a.each do |pair|
    edge_counts[pair.sort] += 1
  end

  print ?.
  #pp edge_counts.sort_by(&:last).reverse.first(5)
end
puts

# Remove 3 most used edges from the graph
edge_counts.sort_by(&:last).last(3).each do |(from, to), _|
  graph[from].delete(to)
  graph[to].delete(from)
end

def flood(node, graph)
  visited = [node].to_set
  queue = [node]

  while queue.any?
    node = queue.shift

    graph[node].each { |to|
      next if visited.include?(to)
      visited << to
      queue << to
    }
  end

  visited
end

# Count the number of nodes in one group
seen = flood(nodes.first, graph).count
pp (graph.keys.count - seen) * seen
