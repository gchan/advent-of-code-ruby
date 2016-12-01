#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
presents  = File.readlines(file_path)

presents.map!(&:to_i)

groups = 3
target = presents.inject(:+) / groups
min_qe = nil

1.upto(presents.size / groups) do |group_size|
  groups = presents.combination(group_size).
    select { |group| group.inject(:+) == target }

  groups.each do |group|
    qe = group.inject(:*)
    min_qe = [qe, min_qe].compact.min
  end

  break if min_qe
end

puts min_qe
