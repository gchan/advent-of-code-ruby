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

ids
  .each_line
  .map(&:to_i)
  .count { |id| fresh.any? { |range| range.include?(id) } }
  .tap { |count| puts count }
