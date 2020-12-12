#!/usr/bin/env ruby

file_path = File.expand_path('day-12-input.txt', __dir__)
input     = File.read(file_path)

x, y = 0, 0
x1, y1 = [10, -1]

def rotate(x, y, deg)
  {
    90 => [-y, x],
    270 => [y, -x],
    180 => [-x, -y],
  }[(deg + 360) % 360]
end

input.split("\n").each do |cmd|
  action, val = cmd.match(/(\w)(\d+)/).captures

  val = val.to_i

  case action
  when ?N
    y1 -= val
  when ?E
    x1 += val
  when ?S
    y1 += val
  when ?W
    x1 -= val
  when ?L
    x1, y1 = rotate(x1, y1, -val)
  when ?R
    x1, y1 = rotate(x1, y1, val)
  when ?F
    x += val * x1
    y += val * y1
  end
end

puts [x, y].map(&:abs).sum
