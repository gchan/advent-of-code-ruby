#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

digits = input.chars

digits << digits.first

puts digits.each_cons(2).to_a
  .select { |a, b| a == b }
  .map(&:first)
  .map(&:to_i)
  .inject(:+)
