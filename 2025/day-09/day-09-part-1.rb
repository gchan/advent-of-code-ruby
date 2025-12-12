#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

tiles = input
  .split(/\n|,/)
  .map(&:to_i)
  .each_slice(2)
  .to_a

tiles.combination(2).lazy
  .map { |(x1, y1), (x2, y2)|
    ((x1 - x2).abs + 1) * ((y1 - y2).abs + 1)
  }
  .max
  .tap { puts _1 }
