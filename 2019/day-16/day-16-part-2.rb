#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

digits = input.chars.map(&:to_i) * 10000

offset = digits[0, 7].join.to_i

digits = digits[offset..]

100.times do |time|
  result = []

  # Bottom half digits is a triangular matrix.
  # From the offset, we are certainly in the bottom half.
  sum = digits.inject(:+)

  digits.length.times do |i|
    result << sum.abs % 10

    sum -= digits[i]
  end

  digits = result
end

puts digits[0, 8].join
