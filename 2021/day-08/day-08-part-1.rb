#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n")
  .map { |line| line.split("|").last }
  .flat_map(&:split)
  .count { |x| [2, 3, 4, 7].include?(x.length) }
