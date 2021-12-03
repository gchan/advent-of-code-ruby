#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

numbers = input.split("\n")

gamma = numbers.map(&:chars).transpose.map do |bits|
  count = bits.select.count { |bit| bit == "0" }

  if count > bits.size / 2
    "0"
  else
    "1"
  end
end

gamma = gamma.join.to_i(2)
epsilon = gamma ^ (2**12 - 1)

puts gamma * epsilon

