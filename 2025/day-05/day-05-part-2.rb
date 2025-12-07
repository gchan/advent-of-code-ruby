#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

ranges, ids = input.split("\n\n")

fresh = ranges
  .each_line
  .map { |line|
    line
      .split("-")
      .map(&:to_i)
      .then { Range.new(_1, _2) }
  }
  .sort_by(&:begin)

reduced_fresh = []

current = fresh.shift

while current
  next_range = fresh.first

  if next_range && current.end >= next_range.begin
    current = Range.new(current.begin, [current.end, next_range.end].max)
    fresh.shift
  else
    reduced_fresh << current
    current = fresh.shift
  end
end

reduced_fresh
  .map { _1.end - _1.begin + 1 }
  .sum
  .tap { puts _1}
