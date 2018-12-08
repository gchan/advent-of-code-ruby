#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

numbers = input.split.map(&:to_i)

def sum(numbers)
  child_nodes = numbers.shift
  meta_entries = numbers.shift

  sum = 0

  child_nodes.times do
    sum += sum(numbers)
  end

  meta_entries.times do
    sum += numbers.shift
  end

  sum
end

puts sum(numbers)
