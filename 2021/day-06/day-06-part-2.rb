#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

fishes = input.split(",").map(&:to_i).sort.tally

fishes.default = 0

256.times do
  fishes.transform_keys! { |k| k - 1 }

  fishes[6] += fishes[-1]
  fishes[8] = fishes[-1]

  fishes[-1] = 0
end

puts fishes.values.inject(&:+)
