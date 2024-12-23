#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.read(file_path)

connections = Hash.new { |h, k| h[k] = Set.new }

input.split.each { |connection|
  c1, c2 = connection.split(?-)

  connections[c1].add(c2)
  connections[c2].add(c1)
}

sets = Set.new

input.split
  .map { _1.split(?-) }
  .each { |c1, c2| sets.add([c1, c2].sort) }

while sets.count > 1
  p [sets.first.size, sets.count]

  new_sets = Set.new

  sets.each { |set|
    c1 = set.first
    connections[c1].each { |c2|
      next if set.include?(c2)
      next if set[1..].any? { |c3| !connections[c3].include?(c2) }

      new_sets.add((set.clone << c2).sort)
    }
  }

  sets = new_sets
end

puts sets.first.join(?,)
