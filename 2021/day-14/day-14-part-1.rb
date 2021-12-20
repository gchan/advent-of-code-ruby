#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

polymer, insertion_rules = input.split("\n\n")

rules = {}

insertion_rules.split("\n").map do |rule|
  from, insert = rule.split(" -> ")

  rules[from] = insert
end

10.times do
  new_polymer = polymer.chars.each_cons(2).map do |pair|
    pair = pair.join

    if rules[pair]
      pair[0] + rules[pair]
    else
      pair[0]
    end
  end

  new_polymer << polymer.chars.last

  polymer = new_polymer.join
end

puts polymer.chars.tally.values.minmax.inject(&:-).abs
