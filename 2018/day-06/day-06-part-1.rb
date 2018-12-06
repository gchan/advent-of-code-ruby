#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

ords = input.split("\n").map do |ord|
  x, y = ord.split(",").map(&:to_i)
end

rows = ords.map(&:first).max + 1
cols = ords.map(&:last).max + 1

counts = Array.new(ords.size, 0)
infinite = Set.new

(rows + 2).times do |x|
  (cols + 2).times do |y|
    distances = {}

    ords.map.with_index do |(x1, y1), idx|
      distances[idx] = (x - x1 + 1).abs + (y - y1 + 1).abs
    end

    min = distances.values.min

    min_ords = distances.select { |idx, dist| dist == min }
    ord_idx = min_ords.keys.first

    if min_ords.size == 1
      counts[ord_idx] += 1

      if x == 0 || y == 0 || x == rows + 1 || y == cols + 1
        infinite.add(ord_idx)
      end
    end
  end
end

infinite.each do |ig|
  counts[ig] = 0
end

puts counts.max
