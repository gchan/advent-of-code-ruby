#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

scores = input.each_line.map { |line|
  opp, you = line.split

  opp = %w(A B C).index(opp)
  you = %w(X Y Z).index(you)

  score = you + 1
  if opp == you
    score += 3 # draw
  elsif (opp + 1) % 3 == you
    score += 6 # win
  end

  score
}

puts scores.sum
