#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

input
  .each_line
  .map(&:split)
  .transpose
  .map { _1[0...-1].map(&:to_i).inject(_1[-1]) }
  .sum
  .tap { puts _1 }
