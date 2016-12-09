#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

idx = 0
length = 0

while idx < input.length do
  if input[idx] == '('
    marker = input[idx..-1].match(/\(([0-9x]*)\)/)[1]

    chars, repeat = marker.split("x").map(&:to_i)

    length += chars * repeat
    idx    += chars + marker.length + 2
  else
    length += 1
    idx += 1
  end
end

puts length
