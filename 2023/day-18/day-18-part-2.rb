#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

DIRS = {
  U: [0, -1],
  D: [0, 1],
  L: [-1, 0],
  R: [1, 0]
}

pos = [0, 0]
points = [pos]
boundary = 0

input.each_line {
  _, _, hex = _1.split
  hex = hex[2, 6]
  dis = hex[0..4].to_i(16)
  dir = [?R, ?D, ?L, ?U][hex[-1].to_i]

  boundary += dis

  pos = DIRS[dir.to_sym]
    .map { |mod| mod * dis }
    .zip(pos)
    .map(&:sum)

  points << pos
}

# Shoe-lace formula to caclulate an area of a polygon
# https://en.wikipedia.org/wiki/Shoelace_formula#Trapezoid_formula_2
#
# Then add the perimeter area which is number of points / 2 + 1
# The plus one is to account for the net extra four quarter of area
# from each corner. Some corners represent only a quarter of area,
# while others represent three quarters. But the net amount will
# be 4 quarters (imagine a basic square with 4 corners).
#
points.count.times
  .map { |i|
    ni = (i + 1) % points.size
    (points[i][1] + points[ni][1]) * (points[i][0] - points[ni][0])
  }
  .sum.abs
  .then { _1 / 2 }
  .then { _1 + boundary / 2 + 1 }
  .tap { puts _1 }
