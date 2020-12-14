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

    idx = idx.to_i.to_s(2)
    val = val.to_i

    result = mask.reverse.chars.zip(idx.reverse.chars).map do |m, i|
      if m == ?1
        1
      elsif m == ?X
        'X'
      else
        i || 0
      end
    end

    addresses = result.count { |c| c == ?X }

    (2**addresses).times do |i|
      address = result.join
      bin = i.to_s(2).rjust(addresses, '0')

      bin.chars.each do |j|
        address.sub!(?X, j)
      end

      mem[address.reverse.to_i(2)] = val
    end
  end
end

puts mem.values.sum
