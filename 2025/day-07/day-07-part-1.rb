#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

lines = input
  .each_line
  .each_slice(2) # skip every second line
  .map(&:first)

beams = [
  lines.first.index("S")
]

splits = 0

lines[1..-1].each do |line|
  new_beams = []

  beams.each do |beam|
    if line[beam] == ?^
      splits += 1

      new_beams << beam - 1
      new_beams << beam + 1
    else
      new_beams << beam
    end
  end

  beams = new_beams.uniq
end

puts splits
