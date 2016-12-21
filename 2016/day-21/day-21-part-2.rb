#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

string = "fbgdceah"

lines.reverse.each do |line|
  if line.include?("swap position")
    i, j = line.match(/(\d+).*(\d+)/)[1..2].map(&:to_i)
    string[i], string[j] = string[j], string[i]

  elsif line.include?("swap letter")
    m, n = line.match(/(\w) with letter (\w)/)[1..2]
    string.tr!(m + n, n + m)

  elsif line.include?("reverse positions")
    i, j = line.match(/(\d*) through (\d*)/)[1..2].map(&:to_i)
    string[i..j] = string[i..j].reverse

  elsif line =~ /rotate (left|right)/
    direction, steps = line.match(/(left|right) (\d*) step/)[1..2]

    steps = steps.to_i
    steps *= -1 if direction == "right"
    string = string.chars.rotate(-steps).join

  elsif line.include?("rotate based on position of letter")
    letter = line.match(/letter (\w)/)[1]
    idx = string.chars.index(letter)

    steps = idx / 2
    if idx % 2 == 1 || idx == 0
      steps += 1
    else
      steps += 5
    end

    string = string.chars.rotate(steps).join

  elsif line.include?("move position ")
    i, j = line.match(/(\d*) to position (\d*)/)[1..2].map(&:to_i)

    chars = string.chars
    chars.insert(i, chars.delete_at(j))
    string = chars.join
  end
end

puts string
