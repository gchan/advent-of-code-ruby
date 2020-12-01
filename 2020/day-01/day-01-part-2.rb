#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

set = input.split("\n").map(&:to_i).to_set

set.to_a.combination(2) do |v, w|
  expect = 2020 - v - w

  if set.include?(expect)
    puts expect * v * w
    break
  end
end
