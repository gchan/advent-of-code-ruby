#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

polymer, insertion_rules = input.split("\n\n")

rules = {}

insertion_rules.split("\n").map do |rule|
  from, insert = rule.split(" -> ")

  rules[from] = from.chars.zip([insert]).flatten.compact.each_cons(2).to_a
end

element_count = Hash.new { |h, k| h[k] = 0 }

polymer.chars.each do |e|
  element_count[e] += 1
end

pairs = polymer.chars.each_cons(2).tally

40.times do
  new_pairs = Hash.new { |h, k| h[k] = 0 }

  pairs.each do |pair, count|
    if rules[pair.join]
      new_element = rules[pair.join].first[1]
      element_count[new_element] += count

      rules[pair.join].each do |new_pair|
        new_pairs[new_pair] += count
      end
    else
      new_pairs[pair] += count
    end
  end

  pairs = new_pairs
end

puts element_count.values.minmax.inject(&:-).abs

