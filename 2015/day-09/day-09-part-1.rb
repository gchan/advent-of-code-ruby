#!/usr/bin/env ruby

# It's only 8 nodes (locations), so we can brute force with no problem :)
# !8 = 40320 possible paths

file_path = File.expand_path("../day-09-input.txt", __FILE__)
distances = File.readlines(file_path)

locations = Hash.new { |hash, key| hash[key] = {} }

distances.each do |distance|
  from, _, to = distance.scan(/[A-z]+/)
  length      = distance.scan(/\d+/)[0].to_i

  locations[from][to] = length
  locations[to][from] = length
end

route_lengths = locations.keys.permutation.map do |path|
  path.each_cons(2).inject(0) do |total, (from, to)|
    total + locations[from][to]
  end
end

puts route_lengths.min
