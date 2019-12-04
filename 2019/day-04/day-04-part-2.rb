#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

from, to = input.split("-").map(&:to_i)

count = 0

(from..to).each do |pw|
  digits = pw.to_i.digits

  increasing = digits.each_cons(2).all? do |a, b|
    a >= b
  end

  double = digits.chunk(&:itself).any? do |_, chunk|
    chunk.size == 2
  end

  count += 1 if increasing && double
end

puts count
