#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

depths = input.split("\n").map(&:to_i)

puts depths.each_cons(4).count do |a, b, c, d|
  (b + c + d) > (a + b + c)
end
