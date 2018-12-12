#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

generations = 50000000000

input = input.split("\n")

state = input[0]
pots = Array.new(state.size + 4, ".")

adjust = 2

state.split(" ").last.chars.each_with_index do |pot, idx|
  pots[idx + adjust] = pot
end

rules = {}

input[2..-1].each do |rule|
  pattern, pot = rule.split(" => ")

  rules[pattern] = pot
end

seen = Set.new

i = 0

loop do
  i += 1

  next_pots = Array.new(pots.size + 4, ".")

  pots.each_cons(5).with_index do |pots, idx|
    patern = pots.join
    result = rules[patern]
    next_pots[idx + 2] = result || "."
  end

  pots = next_pots

  first = pots.find_index("#")
  last = pots.size - 1 - pots.reverse.find_index("#")

  viewed = pots[first..last].join

  break if seen.include?(viewed)

  seen.add(viewed)
end

sum = 0

pots.each.with_index do |pot, idx|
  sum += idx + (generations - i) - adjust if pot == "#"
end

puts sum
