#!/usr/bin/env ruby

file_path = File.expand_path('day-14-input.txt', __dir__)
input     = File.read(file_path)

lines = input.split("\n")

mem  = {}
mask = nil

lines.each do |line|
  if line.include?("mask")
    mask = line.match(/= (.*)/).captures.first
  else
    idx, val = line.match(/\[(\d+)\] = (\d+)/).captures

    idx = idx.to_i
    val = val.to_i.to_s(2)

    result = mask.reverse.chars.zip(val.reverse.chars).map do |m, v|
      if m != ?X
        m
      else
        v || 0
      end
    end

    mem[idx] = result.reverse.join.to_i(2)
  end
end

puts mem.values.sum
