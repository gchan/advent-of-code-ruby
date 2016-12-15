#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

discs = []

discs = input.split("\n").map.with_index do |disc, idx|
  positions = disc.match(/(\d*) positions/)[1].to_i
  start = disc.match(/position (\d*)/)[1].to_i

  [idx, positions, start]
end

def fall_through?(time, discs)
  discs.all? do |disc|
    (disc[0] + 1 + time + disc[2]) % disc[1] == 0
  end
end

time = 0

while !fall_through?(time, discs)
  time += 1
end

puts time
