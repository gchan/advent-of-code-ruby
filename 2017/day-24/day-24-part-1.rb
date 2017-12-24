#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input = File.read(file_path)

comps = input.split("\n")
  .map { |comp| comp.split('/').map(&:to_i) }

max = 0

queue = comps.select { |comp| comp.include?(0) }
  .map { |comp|
    remaining = comps.reject { |c| c == comp }
    target = comp[0]
    target = comp[1] if target == 0
    sum = comp.inject(:+)

    [remaining, target, sum]
  }

while queue.any?
  comps, target, sum = queue.pop

  max = [sum, max].max

  comps.select { |comp| comp.include?(target) }.each do |comp|
    remaining = comps.reject { |c| c == comp }
    new_target = comp[0]
    new_target = comp[1] if new_target == target
    new_sum = sum + comp.inject(:+)

    queue << [remaining, new_target, new_sum]
  end
end

puts max
