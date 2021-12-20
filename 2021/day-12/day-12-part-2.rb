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

Path = Struct.new(:second_visit, :path)

count = 0
queue = [Path.new(false, ["start"])]

while queue.any?
  path = queue.shift

  caves[path.path.last].each do |neighbour|
    second_visit = neighbour.downcase == neighbour && path.path.include?(neighbour)

    next if second_visit && path.second_visit

    visited_twice = path.second_visit || second_visit
    new_path = Path.new(visited_twice, path.path + [neighbour])

    count += 1 if neighbour == "end"
    queue << new_path
  end
end

puts count
