#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

one = input.match(/1:\s((\d+\s)+)/).captures.first.split.map(&:to_i)
two = input.match(/2:\s((\d+\s)+)/).captures.first.split.map(&:to_i)

while one.any? && two.any?
  o = one.shift
  t = two.shift

  if o > t
    one << o
    one << t
  else
    two << t
    two << o
  end
end

winner = one.any? ? one : two

puts winner.reverse.map.with_index { |num, idx| num * (idx + 1) }.sum

