#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

a, b = input.scan(/\d+$/).map(&:to_i)

count = 0
mask = 2 ** 16 - 1

5_000_000.times do
  loop do
    a = (a * 16807) % 2147483647
    break if a % 4 == 0
  end

  loop do
    b = (b * 48271) % 2147483647
    break if b % 8 == 0
  end

  count += 1 if (a ^ b) & mask == 0
end

puts count
