#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

goal = 272

a = input.chars.map(&:to_i)

while a.length < goal
  b = a.reverse.map do |bit|
    if bit == 0
      1
    else
      0
    end
  end

  a << 0
  a.concat b
end

a = a[0..(goal-1)]
puts a.length

sum = a

while sum.length % 2 == 0
  next_sum = []

  sum.each_slice(2) do |x, y|
    if x == y
      next_sum << 1
    else
      next_sum << 0
    end
  end

  sum = next_sum
end

puts sum.join
