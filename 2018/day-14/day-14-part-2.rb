#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

scores = [3, 7]

one = 0
two = 1

target = input.chars.map(&:to_i)

last = []

loop do
  sum = scores[one] + scores[two]

  sum.to_s.chars.map(&:to_i).each do |a|
    scores << a
    last << a

    if last.length == target.length && last == target
      puts scores.length - target.length
      exit
    elsif last.length >= target.length
      last.shift
    end
  end

  one += 1 + scores[one]
  two += 1 + scores[two]

  one %= scores.length
  two %= scores.length

  puts scores.length if scores.length % 1_000_000 == 0
end
