#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

stones = input.split.map(&:to_i)

blinks = 25

blinks.times {
  stones = stones.flat_map {
    if _1 == 0
      1
    elsif _1.to_s.chars.count.even?
      digits = _1.to_s.chars
      length = digits.size
      [
        digits[0..length/2 - 1].join.to_i,
        digits[(length/2)..-1].join.to_i
      ]
    else
      _1 * 2024
    end
  }
}

puts stones.count
