#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
lines     = File.readlines(file_path).map(&:strip)

code_characters    = lines.map(&:length).inject(:+)
encoded_characters = lines.map(&:inspect).map(&:length).inject(:+)

puts encoded_characters - code_characters
