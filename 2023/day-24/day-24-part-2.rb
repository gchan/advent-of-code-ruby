#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

stones = input.each_line.map {
  pos, vel = _1.split(?@)

  pos = pos.strip.split(?,).map(&:to_i)
  vel = vel.strip.split(?,).map(&:to_i)

  [pos, vel]
}

# gem install 'prime'
require 'prime'

def factors_of(number)
  primes, powers = number.prime_division.transpose
  exponents = powers.map { (0.._1).to_a }

  exponents.shift.product(*exponents).map do |powers|
    primes
      .zip(powers)
      .map { |prime, power| prime ** power }
      .inject(:*)
  end
end

# Infer rock velocities by identifying hailstones with the same velocities
# across one dimension, and identifying the factors in the difference in
# that dimension.
#
# The rock's velocity, vx, must move as factor of the difference of two
# hailstones (with respect to relative velocities of the hailstones):
#
# vx = hailstone velocity +/- factor of the difference between two hailstones
#
# https://www.reddit.com/r/adventofcode/comments/18qcfsp
#
# idx - x, y, z
#
# 0 - x
# 1 - y
# 2 - z
#
def rock_v(idx, stones)
  stones
    .group_by { |pos, vel| vel[idx] }
    .select { |vel, stones| stones.size == 2 }
    .transform_values { _1.map { |pos, _vel| pos[idx] } }
    .map { |v, p|
      [
        v,
        p.inject(&:-).abs
      ]
    }
    .select { |_v, d| d != 0 }
    .map { |v, d|
      factors_of(d).flat_map { |f| [v - f, v + f] }
    }
    .inject(&:&)
    .first
end

# Find the common intersection point for a series of hail stones.
#
# A moving rock is the same as the keeping the rock stationary and
# adjusting the hailstone velocities relative to the rock's velocity
#
# Components (comp) is an array composed of two dimensions:
#
# 0 - x
# 1 - y
# 2 - z
#
def intersection(stones, comp, rock_v0, rock_v1)
  stones.combination(2).map { |s1, s2|
    p1, v1 = s1
    p2, v2 = s2

    a1 = (v1[comp[1]] - rock_v1) / (v1[comp[0]] - rock_v0).to_f
    b1 = p1[comp[1]] - (a1 * p1[comp[0]])

    a2 = (v2[comp[1]] - rock_v1) / (v2[comp[0]] - rock_v0).to_f
    b2 = p2[comp[1]] - (a2 * p2[comp[0]])

    # Use y = ax + b and a bit of algebra to solve for x and y
    #
    # x - component 1
    # y - component 2
    x = (b2 - b1).to_f / (a1 - a2)
    y = a1 * x + b1

    [x, y].map(&:round).map(&:to_i)
  }
    .tally.sort_by(&:last).last.first
end

rvx = rock_v(0, stones)
rvy = rock_v(1, stones)
rvz = rock_v(2, stones)

pp rvx
pp rvy
pp rvz

x, y = intersection(stones.sample(3), [0, 1], rvx, rvy)
_, z = intersection(stones.sample(3), [0, 2], rvx, rvz)

pp x + y + z
