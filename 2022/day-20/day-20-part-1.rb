#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input     = File.read(file_path)

nums = input.split.map(&:to_i)
  .each_with_index.map { [_1, _2] }

nums.length.times { |n|
  idx = nums.index { _2 == n }

  val = nums.delete_at(idx)

  nums.insert((idx + val[0]) % nums.size, val)
}

idx = nums.index { _1[0] == 0 }

puts nums[(idx + 1000) % nums.length][0] +
  nums[(idx + 2000) % nums.length][0] +
  nums[(idx + 3000) % nums.length][0]
