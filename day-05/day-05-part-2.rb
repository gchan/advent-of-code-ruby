#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
strings   = File.readlines(file_path)

strings.select! do |string|
  string.chars.each_cons(3).any? { |a, _b, c| a == c }
end

# Could be better
strings.select! do |string|
  (string.length - 3).times.any? do |index|
    pair = string[index, 2]

    string[(index + 2)..-1].chars.
      each_cons(2).
      map(&:join).
      any? { |pair2| pair2 == pair }
  end
end

puts strings.count
