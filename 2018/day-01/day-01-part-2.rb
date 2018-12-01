#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

changes = input.split("\n")

sum = 0
sums = Set.new

while true
  changes.each do |change|
    sum += change.to_i

    if sums.include?(sum)
      puts sum
      exit
    end

    sums.add(sum)
  end
end
