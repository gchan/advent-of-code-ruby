#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

x = 0
y = 0

max = 0

input.split(",").each do |dir|
  case dir
  when "ne"
    x += 1
  when "sw"
    x -= 1
  when "se"
    x += 1
    y += 1
  when "nw"
    x -= 1
    y -= 1
  when "s"
    y += 1
  when "n"
    y -= 1
  end

  max = [x.abs, y.abs, (x - y).abs, max].max
end

puts max
