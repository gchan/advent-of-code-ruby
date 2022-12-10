#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

scores = input.each_line.map { |line|
  opp, you = line.split

  opp = %w(A B C).index(opp)

  case you
  when "X" # lose
    score = 1 + (opp - 1) % 3
  when "Y" # draw
    score = 1 + opp + 3
  when "Z" # win
    score = 1 + (opp + 1) % 3 + 6
  end
}

puts scores.sum
