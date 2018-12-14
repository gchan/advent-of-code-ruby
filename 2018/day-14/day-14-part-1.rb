#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

scores = [3, 7]

one = 0
two = 1

target = input.to_i

while scores.length < (target + 10) do
  sum = scores[one] + scores[two]

  scores.concat(sum.to_s.chars.map(&:to_i))

  one += 1 + scores[one]
  two += 1 + scores[two]

  one %= scores.length
  two %= scores.length
end

puts scores[-10..-1].join
