#!/usr/bin/env ruby

file_path = File.expand_path("../day-8-input.txt", __FILE__)
lines     = File.readlines(file_path).map(&:strip)

code_characters   = lines.map(&:length).inject(:+)
memory_characters = lines.map { |line| eval(line).length }.inject(:+)

puts code_characters - memory_characters
