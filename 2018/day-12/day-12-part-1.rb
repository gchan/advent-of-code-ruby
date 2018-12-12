#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

generations = 20

input = input.split("\n")

state = input[0]
num_pots = (state.size + generations) * 2
pots = Array.new(num_pots, ".")

state.split(" ").last.chars.each_with_index do |pot, idx|
  pots[idx + num_pots / 2] = pot
end

rules = {}

input[2..-1].each do |rule|
  pattern, pot = rule.split(" => ")

  rules[pattern] = pot
end

generations.times do
  next_pots = Array.new(num_pots, ".")

  pots.each_cons(5).with_index do |pots, idx|
    patern = pots.join
    result = rules[patern]
    next_pots[idx + 2] = result || "."
  end

  pots = next_pots
end

sum = 0

pots.each.with_index do |pot, idx|
  sum += idx - num_pots / 2 if pot == "#"
end

puts sum
