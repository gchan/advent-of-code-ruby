#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n")
  .map { |row| row.split(" ") .map(&:to_i).sort }
  .map { |row| row.last - row.first }
  .inject(:+)
