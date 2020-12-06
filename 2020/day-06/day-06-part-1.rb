#!/usr/bin/env ruby

file_path = File.expand_path('day-06-input.txt', __dir__)
input     = File.read(file_path)

groups = input.split("\n\n")

puts groups
  .map { |g| g.gsub(/\s/, '').chars.uniq.count }
  .sum
