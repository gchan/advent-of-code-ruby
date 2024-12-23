#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.read(file_path)

connections = Hash.new { |h, k| h[k] = Set.new }

input.split.each { |connection|
  c1, c2 = connection.split(?-)

  connections[c1].add(c2)
  connections[c2].add(c1)
}

triplets = Set.new

connections.each { |c1, connected|
  connected.to_a.combination(2).each { |c2, c3|
    next if !connections[c2].include?(c3)
    triplets.add([c1, c2, c3].sort)
  }
}

triplets.to_a
  .map { _1.join(?,) }
  .count { _1.match?(/(\A|,)t/) }
  .tap { puts _1 }
