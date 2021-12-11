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
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

points = 0

input.split("\n").map do |line|
  expectations = []

  line.chars.each do |char|
    if CHARS.include?(char)
      expectations << CHARS[char]
    elsif expectations.last == char
      expectations.pop
    else
      points += POINTS[char]
      break
    end
  end
end

puts points
