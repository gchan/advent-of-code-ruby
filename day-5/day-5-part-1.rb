#!/usr/bin/env ruby

file_path = File.expand_path("../day-5-input.txt", __FILE__)
input     = File.read(file_path)

strings = input.split("\n")

strings.reject! { |string| string =~ /ab|cd|pq|xy/ }

strings.reject! do |string|
  string.chars.select { |char| %w(a e i o u).include?(char) }.count < 3
end

strings.select! do |string|
  string.chars.each_cons(2).any? { |a, b| a == b }
end

puts strings.count
