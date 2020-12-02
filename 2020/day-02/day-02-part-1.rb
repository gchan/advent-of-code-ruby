#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n").count { |line|
  policy, password  = line.split(":").map(&:strip)

  counts, char = policy.split(" ")
  min, max = counts.split("-").map(&:to_i)

  char_count = password.chars.count { |c| c == char }

  (min..max).cover?(char_count)
}
