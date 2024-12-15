#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

regex = /
  mul\(
    (\d+),
    (\d+)
  \)
/x

puts input.scan(regex)
  .flatten
  .map(&:to_i)
  .each_slice(2)
  .map { _1.inject(:*) }
  .sum
