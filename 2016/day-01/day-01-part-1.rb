#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

dir = 0

x = 0
y = 0

input.gsub(",", "").split.each do |cmd|
  if cmd[0] == "L"
    dir -= 1
  else # R
    dir += 1
  end

  dir %= 4

  blocks = cmd[1..-1].to_i

  case dir
  when 0
    y += blocks
  when 1
    x += blocks
  when 2
    y -= blocks
  when 3
    x -= blocks
  end
end

puts x.abs + y.abs
