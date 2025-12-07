#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.each_line.to_a

lines.last.strip
  .chars
  .each_with_index
  .select { |char, _idx| char != " " }
  .map { _2 } # get indices of operators
  .<<(lines.map(&:length).max)
  .each_cons(2)
  # Build ranges from the start of the current range to end of the previous
  # range minus one (to account for space)
  .map { _1..(_2 - 2) }
  .map { |range|
    lines[0...-1]
      .map { _1[range] }
      .map { _1.ljust(range.size, " ") }
      .map(&:chars)
      .transpose
      .map(&:join)
      .map(&:to_i)
      .inject(lines.last[range.begin])
  }
  .sum
  .tap { puts _1 }
