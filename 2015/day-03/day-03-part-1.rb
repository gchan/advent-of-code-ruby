#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

x = 0
y = 0

homes = Set.new
homes.add("#{x},#{y}")

input.chars.each do |direction|
  case direction
  when '>'
    x += 1
  when '<'
    x -= 1
  when '^'
    y -= 1
  when 'v'
    y += 1
  end

  homes.add("#{x},#{y}")
end

puts homes.count
