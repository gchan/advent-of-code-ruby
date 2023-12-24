#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

stones = input.each_line.map {
  pos, vel = _1.split(?@)

  pos = pos.strip.split(?,).map(&:to_i)
  vel = vel.strip.split(?,).map(&:to_i)

  # Solve for a and b in y = ax + b
  a = vel[1] / vel[0].to_f
  b = pos[1] - (a * pos[0])
  [pos, vel, a, b]
}

from = 200000000000000
to = 400000000000000

stones.combination(2).count { |s1, s2|
  p1, v1, a1, b1 = s1
  p2, v2, a2, b2 = s2

  next if (a1 - a2) == 0

  # Use y = ax + b and a bit of algebra to solve for x and y
  x = (b2 - b1).to_f / (a1 - a2)
  y = a1 * x + b1

  next if x > p1[0] && v1[0] < 0
  next if x < p1[0] && v1[0] > 0
  next if x > p2[0] && v2[0] < 0
  next if x < p2[0] && v2[0] > 0

  x >= from && x <= to && y >= from && y <= to
}.tap { puts _1 }

