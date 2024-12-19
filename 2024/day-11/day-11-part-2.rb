#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

blinks = 75

stones = {}
input.split.map(&:to_i).each { stones[_1] = 1 }

blinks.times {
  new_stones = Hash.new { |h, k| h[k] = 0 }

  stones.each { |stone, count|
    if stone == 0
      new_stones[1] += count
    elsif stone.to_s.chars.count.even?
      digits = stone.to_s.chars
      length = digits.size

      left = digits[0..length/2 - 1].join.to_i
      right = digits[(length/2)..-1].join.to_i

      new_stones[left] += count
      new_stones[right] += count
    else
      new_stones[stone * 2024] += count
    end
  }

  stones = new_stones
}

puts stones.values.sum
