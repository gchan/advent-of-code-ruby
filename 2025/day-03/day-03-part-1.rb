#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

banks = input.split("\n").map(&:chars).map { _1.map(&:to_i) }

banks.sum { |bank|
  tens, idx = bank[0...-1]
    .each.with_index
    .max_by { |value, _idx| value }

  ones = bank[(idx + 1)..-1].max

  tens * 10 + ones
}.tap { puts _1 }
