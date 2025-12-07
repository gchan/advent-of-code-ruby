#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

lines = input
  .each_line
  .each_slice(2) # skip every second line
  .map(&:first)

beams = {
  lines.first.index("S") => 1
}

lines[1..-1].each do |line|
  new_beams = Hash.new(0)

  beams.each do |beam, count|
    if line[beam] == ?^
      new_beams[beam - 1] += count
      new_beams[beam + 1] += count
    else
      new_beams[beam] += count
    end
  end

  beams = new_beams
end

puts beams.values.sum
