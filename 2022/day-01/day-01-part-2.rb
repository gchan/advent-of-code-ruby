#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n\n")
  .map{ |calories| calories.split.map(&:to_i).sum }
  .sort
  .last(3)
  .sum
