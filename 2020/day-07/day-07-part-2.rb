#!/usr/bin/env ruby

file_path = File.expand_path('day-07-input.txt', __dir__)
input     = File.read(file_path)

children_bags = {}

input.split("\n").each do |line|
  parent, contain = line.match(/(\w+ \w+) bags contain (.*)\./)[1..2]

  children = contain.split(",")
    .reject { |child| child.include?("no other") }
    .map { |child|
      [
        child.match(/\d+/)[0].to_i,
        child.match(/(\w+ \w+) bag/)[1]
      ]
    }

  children_bags[parent] = children
end

sum = 0
queue = [["shiny gold", 1]]

while queue.any?
  parent, parent_count = queue.shift

  children_bags[parent].each do |child_count, child|
    sum += child_count * parent_count
    queue << [child, child_count * parent_count]
  end
end

puts sum
