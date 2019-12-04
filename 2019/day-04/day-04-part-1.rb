#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

from, to = input.split("-").map(&:to_i)

count = 0

(from..to).each do |pw|
  digits = pw.digits

  increasing = digits.each_cons(2).all? do |a, b|
    a >= b
  end

  adjacent = digits.each_cons(2).any? do |a, b|
    a == b
  end

  count += 1 if increasing && adjacent
end

puts count
