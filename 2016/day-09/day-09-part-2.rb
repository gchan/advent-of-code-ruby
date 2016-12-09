#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

def decompress(string)
  idx = 0
  length = 0

  while idx < string.length do
    if string[idx] == '('
      marker = string[idx..-1].match(/\(([0-9x]*)\)/)[1]

      chars, repeat = marker.split("x").map(&:to_i)

      sub_start = idx + marker.length + 2
      substring = string[sub_start...sub_start+chars]

      length += decompress(substring) * repeat
      idx    += chars + marker.length + 2
    else
      length += 1
      idx += 1
    end
  end

  length
end

puts decompress(input)
