#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

priorities = input.each_line.each_slice(3).map { |group|
  error = group.map(&:strip).map(&:chars).inject(:&).first

  priority = error.downcase != error ? 26 : 0
  priority += error.downcase.ord - 'a'.ord + 1
}

puts priorities.sum
