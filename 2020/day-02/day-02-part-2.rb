#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n").count { |line|
  policy, password  = line.split(":").map(&:strip)

  counts, char = policy.split(" ")
  pos_1, pos_2 = counts.split("-").map(&:to_i)

  (password[pos_1 - 1] == char) ^ (password[pos_2 - 1] == char)
}
