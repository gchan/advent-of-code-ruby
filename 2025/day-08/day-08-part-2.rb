#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

boxes = input.split("\n")
  .map { |line| line.split(?,).map(&:to_i) }

sets = []
set_lookup = {}

closest_pairs = boxes
  .combination(2)
  .sort_by { |box1, box2|
    box1.zip(box2)
      .map { |a, b| a - b }
      .map { _1 * _1}
      .sum
      .**(0.5)
  }

while sets.map(&:size).sum < boxes.size
  closest = closest_pairs.shift
  box1, box2 = closest

  if set_lookup[box1] && set_lookup[box2] && set_lookup[box1] == set_lookup[box2]
    next
  end

  closest_sets = closest.map { |box| set_lookup[box] }.compact

  if closest_sets.empty?
    set = Set.new(closest)
    sets << set
    closest.each { set_lookup[_1] = set }
  elsif closest_sets.size == 1
    set = closest_sets.first
    closest.each { |box| set.add(box); set_lookup[box] = set }
  else # merge sets
    set = Set.new
    closest_sets.each { set.merge(_1) }
    closest_sets.each { sets.delete(_1) }

    set.each { |box| set_lookup[box] = set }
    sets << set
  end
end

puts box1[0] * box2[0]
