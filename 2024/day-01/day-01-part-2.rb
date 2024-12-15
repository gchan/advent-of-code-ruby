#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

left, right = input.split(/\s+/)
  .map(&:to_i)
  .each_slice(2)
  .to_a
  .transpose
  .map(&:sort)
  .map(&:tally)

right.default = 0

puts left
  .map { |num, freq| num * freq * right[num] }
  .sum
