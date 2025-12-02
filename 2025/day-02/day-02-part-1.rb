#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

ranges = input.split(?,)

ranges.sum { |range|
  min, max = range.split(?-).map(&:to_i)

  (min..max)
    .select { |n|
      str = n.to_s
      mid = str.length / 2

      str.length.even? && str[0...mid] == str[mid..-1]
    }
    .sum
}.tap { puts _1}
