#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

tiles = input
  .split(/\n|,/)
  .map(&:to_i)
  .each_slice(2)
  .to_a

# Build compressed coordinate mapping
unique_xs = tiles.map(&:first).uniq.sort
unique_ys = tiles.map(&:last).uniq.sort

x_map = unique_xs.each_with_index.to_h
y_map = unique_ys.each_with_index.to_h

# Compressed tiles
compressed_tiles = tiles.map { |x, y| [x_map[x], y_map[y]] }

def build_edge_lookup(tiles, axis:)
  other_axis = 1 - axis

  tiles
    .group_by { _1[axis] }
    .values
    .map(&:sort)
    .flatten(1)
    .each_slice(2)
    .to_a
    .group_by { _1.first[axis] }
    .transform_values { _1.map { |pair| pair.map { |p| p[other_axis] } } }
end

vertical_edge_lookup   = build_edge_lookup(compressed_tiles, axis: 0)
horizontal_edge_lookup = build_edge_lookup(compressed_tiles, axis: 1)

# Find max area rectangle without edges inside
def edges_inside?(range, lookup, c1, c2)
  range.any? do |i|
    lookup[i]&.any? { |e1, e2| (c1 >= e1 && c1 < e2) || (c2 > e1 && c2 <= e2) }
  end
end

tiles.combination(2).lazy
  .map { |(x1, y1), (x2, y2)|
    area = ((x1 - x2).abs + 1) * ((y1 - y2).abs + 1)

    cx1, cx2 = [x_map[x1], x_map[x2]].sort
    cy1, cy2 = [y_map[y1], y_map[y2]].sort

    [area, [cx1, cy1], [cx2, cy2]]
  }
  .reject { |_area, (cx1, cy1), (cx2, cy2)|
    edges_inside?((cx1 + 1)...cx2, vertical_edge_lookup, cy1, cy2) ||
      edges_inside?((cy1 + 1)...cy2, horizontal_edge_lookup, cx1, cx2)
  }
  .map(&:first)
  .max
  .tap { puts _1 }
