#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

numbers = input.split.map(&:to_i)

def sum(numbers)
  child_nodes = numbers.shift
  meta_entries = numbers.shift

  child_sums = child_nodes.times.map do
    sum(numbers)
  end

  entries = meta_entries.times.map do
    numbers.shift
  end

  if child_nodes == 0
    entries.inject(:+)
  else
    entries.map { |idx| child_sums[idx-1] }
      .compact.inject(:+)
  end
end

puts sum(numbers)
