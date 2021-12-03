#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

cmds = input.split("\n")

depth = 0
horizontal = 0
aim = 0

cmds.each do |cmd|
  dir, num = cmd.split

  num = num.to_i

  case dir
  when "forward"
    horizontal += num
    depth += aim * num
  when "up"
    aim -= num
  when "down"
    aim += num
  end
end

puts depth * horizontal
