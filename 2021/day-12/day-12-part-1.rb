#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

caves = Hash.new { |h, k| h[k] = [] }

input.split("\n").each do |line|
  from, to = line.split("-")

  from_cave = caves[from]
  to_cave = caves[to]

  from_cave << to unless "start" == to || "end" == from
  to_cave << from unless "start" == from || "end" == to
end

count = 0
queue = [["start"]]

while queue.any?
  path = queue.shift

  caves[path.last].each do |neighbour|
    next if neighbour.upcase != neighbour && path.include?(neighbour)

    count += 1 if neighbour == "end"

    new_path = path + [neighbour]

    queue << new_path
  end
end

puts count
