#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

a, b = input.scan(/\d+$/).map(&:to_i)

count = 0
mask = 2 ** 16 - 1

40_000_000.times do
  a = (a * 16807) % 2147483647
  b = (b * 48271) % 2147483647

  count += 1 if (a ^ b) & mask == 0
end

puts count
