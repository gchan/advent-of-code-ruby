#!/usr/bin/env ruby

file_path = File.expand_path('day-12-input.txt', __dir__)
input     = File.read(file_path)

lines = input.split("\n")

x, y = 0, 0
facing = [1, 0]

def turn(dir, deg)
  turns = deg / 90
  dirs = [[0, -1], [-1, 0], [0, 1], [1, 0]]
  idx = dirs.index(dir) + turns
  dirs[idx % 4]
end

lines.each do |cmd|
  action, val = cmd.match(/(\w)(\d+)/).captures

  val = val.to_i

  case action
  when ?N
    y -= val
  when ?E
    x += val
  when ?S
    y += val
  when ?W
    x -= val
  when ?L
    facing = turn(facing, val)
  when ?R
    facing = turn(facing, -val)
  when ?F
    x += val * facing[0]
    y += val * facing[1]
  end
end

puts [x, y].map(&:abs).sum
