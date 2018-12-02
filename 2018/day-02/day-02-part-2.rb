#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

boxes = input.split("\n")

boxes.first.length.times do |column|
  counts = Hash.new(0)

  boxes.map do |box|
    id = box[0...column] + box[(column + 1)..-1]
    counts[id] += 1
  end

  counts = counts.invert

  if counts[2]
    puts counts[2]
    break
  end
end
