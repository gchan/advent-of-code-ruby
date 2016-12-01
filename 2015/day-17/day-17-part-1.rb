#!/usr/bin/env ruby

file_path  = File.expand_path("../day-17-input.txt", __FILE__)
containers = File.readlines(file_path)

containers.map!(&:to_i)
liters = 150

combinations = []

1.upto(containers.count) do |container_count|
  combos = containers.combination(container_count).select do |combination|
    combination.inject(:+) == liters
  end

  combinations.concat combos
end

puts combinations.count
