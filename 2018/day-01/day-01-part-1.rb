#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n").map(&:to_i).inject(:+)
