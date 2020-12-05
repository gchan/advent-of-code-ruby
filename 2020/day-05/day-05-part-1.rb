#!/usr/bin/env ruby

file_path = File.expand_path('day-05-input.txt', __dir__)
input     = File.read(file_path)

seats = input.split("\n")

ids = seats.map do |seat|
  rmin, rmax = 0, 127
  cmin, cmax = 0, 7

  seat.split("").each do |c|
    ri = (rmin + rmax) / 2
    ci = (cmin + cmax) / 2

    case c
    when ?F
      rmax = ri
    when ?B
      rmin = ri + 1
    when ?L
      cmax = ci
    when ?R
      cmin = ci + 1
    end
  end

  rmin * 8 + cmin
end

puts ids.max
