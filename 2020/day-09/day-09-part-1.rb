#!/usr/bin/env ruby

# Includes both part 1 and part 2 solutions

file_path = File.expand_path('day-09-input.txt', __dir__)
input     = File.read(file_path)

step = 25

data = input.split("\n").map(&:to_i)

invalid, _ = data.find.with_index do |sum, i|
  next if i < step

  data[i - step, step]
    .combination(2).none? { |pair| pair.sum == sum }
end

puts invalid

data.size.times do |i|
  j = i + 1

  while true
    range = data[i..j]
    sum = range.sum

    if sum == invalid
      puts range.minmax.sum
      exit
    end

    break if sum > invalid
    j += 1
  end
end
