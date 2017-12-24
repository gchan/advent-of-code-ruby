#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input = File.read(file_path)

comps = input.split("\n")
  .map { |comp| comp.split('/').map(&:to_i) }

longest = []

queue = comps.select { |comp| comp.include?(0) }
  .map { |comp|
    remaining = comps.reject { |c| c == comp }
    target = comp[0]
    target = comp[1] if target == 0
    sum = comp.inject(:+)
    chain = [comp]

    [remaining, target, sum, chain]
  }

while queue.any?
  comps, target, sum, chain = queue.pop

  if longest.empty? || chain.size > longest.first.size
    longest = [chain]
  elsif chain.size == longest.first.size
    longest << chain
  end

  comps.select { |comp| comp.include?(target) }.each do |comp|
    remaining = comps.reject { |c| c == comp }
    new_target = comp[0]
    new_target = comp[1] if new_target == target
    new_sum = sum + comp.inject(:+)
    new_chain = chain + [comp]

    queue << [remaining, new_target, new_sum, new_chain]
  end
end

puts longest.map { |chain| chain.flatten.inject(:+) }.max
