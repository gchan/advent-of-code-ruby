#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input = File.read(file_path)

# Reverse engineer and optimise - a = reg[4], b = reg[5]
def activation_system(input)
  b = input

  a = b | 65536
  b = 13159625

  while a > 0
    b += a & 255
    b &= 16777215

    b *= 65899
    b &= 16777215

    a /= 256
  end

  b
end

# It should halt before an infinite loop, identity when that is
visited = Set.new

input = 0

loop do
  visited.add(input)

  output = activation_system(input)

  if visited.include?(output)
    puts input
    exit
  end

  input = output
end
