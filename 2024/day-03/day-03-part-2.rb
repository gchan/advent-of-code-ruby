#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

regex = /
  (
    mul\(
      (\d+),
      (\d+)
    \)
  |
    do[n't]*\(\)
  )
/x

sum = 0
enabled = true

input.scan(regex).each do |instruction, a, b|
  if instruction == "do()"
    enabled = true
  elsif instruction == "don't()"
    enabled = false
  end

  sum += a.to_i * b.to_i if enabled
end

puts sum
