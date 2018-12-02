#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

twos = 0
threes = 0

input.split("\n").each do |row|
  counts = Hash.new(0)

  row.chars.each do |char|
    counts[char] += 1
  end

  counts = counts.invert

  twos += 1 if counts[2]
  threes += 1 if counts[3]
end

puts twos * threes
