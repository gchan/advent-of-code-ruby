#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split(/\s+/)
  .map(&:to_i)
  .each_slice(2)
  .to_a
  .transpose
  .map(&:sort)
  .transpose
  .map { _1.inject(&:-) }
  .map(&:abs)
  .sum
