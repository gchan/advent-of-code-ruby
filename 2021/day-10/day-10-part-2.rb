#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

CHARS = {
  '(' => ')',
  '{' => '}',
  '[' => ']',
  '<' => '>'
}

POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

points = []

input.split("\n").map do |line|
  expectations = []

  line.chars.each do |char|
    if CHARS.include?(char)
      expectations << CHARS[char]
    elsif expectations.last == char
      expectations.pop
    else
      expectations.clear
      break
    end
  end

  # Skip if corrupt
  next if expectations.empty?

  score = 0
  expectations.reverse.each do |char|
    score *= 5
    score += POINTS[char]
  end

  points << score
end

puts points.sort[points.size / 2]
