#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input     = File.read(file_path)

ranges = input.split("\n").map do |range|
  range.split("-").map(&:to_i)
end

ranges.sort.each_cons(2) do |range_one, range_two|
  if range_one[1] < range_two[0] - 1
    puts range_one[1] + 1
    exit
  end
end
