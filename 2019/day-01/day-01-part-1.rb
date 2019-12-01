#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

fuel = 0

modules = input.split("\n").map(&:to_i)

modules.each do |mass|
  fuel += mass / 3 - 2
end

puts fuel
