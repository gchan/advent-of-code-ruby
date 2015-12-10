#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

numbers = input.chars.map(&:to_i)

50.times do
  numbers = numbers.slice_when { |before, after| before != after }.
    flat_map { |numbers| [numbers.count, numbers.first] }
end

puts numbers.length
