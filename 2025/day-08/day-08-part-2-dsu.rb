#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

# DSU (Union Find) implenmentation
# https://cp-algorithms.com/data_structures/disjoint_set_union.html
class DisjointSetUnion
  def initialize(size)
    @parent = Array.new(size) { _1 }
    @rank = Array.new(size, 0)
  end

  def find(e)
    if @parent[e] != e
      @parent[e] = find(@parent[e])
    end
    @parent[e]
  end

  def union(u, v)
    root_u = find(u)
    root_v = find(v)

    return false if root_u == root_v

    if @rank[root_u] < @rank[root_v]
      @parent[root_u] = root_v
    elsif @rank[root_u] > @rank[root_v]
      @parent[root_v] = root_u
    else
      @parent[root_v] = root_u
      @rank[root_u] += 1
    end

    true
  end
end

boxes = input.split("\n")
  .map { |line| line.split(?,).map(&:to_i) }

closest_pairs = []

boxes.size.times do |i|
  (i+1...boxes.size).each do |j|
    dist = boxes[i].zip(boxes[j])
      .map { |a, b| a - b }
      .map { _1 * _1}
      .sum

    closest_pairs << [dist, i, j]
  end
end

closest_pairs.sort_by!(&:first)

dsu = DisjointSetUnion.new(boxes.size)

circuits = boxes.size

while circuits > 1
  _dist, box1, box2 = closest_pairs.shift

  merged = dsu.union(box1, box2)

  circuits -= 1 if merged
end

puts boxes[box1][0] * boxes[box2][0]
