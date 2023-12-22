#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

def overlap?(range1, range2)
  range1.cover?(range2.begin) || range2.cover?(range1.begin)
end

def intersect?(brick, other)
  bf = brick[0]
  bt = brick[1]
  of = other[0]
  ot = other[1]

  bx = bf[0]..bt[0]
  by = bf[1]..bt[1]
  bz = bf[2]..bt[2]

  ox = of[0]..ot[0]
  oy = of[1]..ot[1]
  oz = of[2]..ot[2]

  overlap?(bx, ox) && overlap?(by, oy) && overlap?(bz, oz)
end

bricks = input.each_line.map do
  _1.strip.split(?~).map { |pos| pos.split(?,).map(&:to_i) }
end

bricks.sort_by! { |from, _| from.last }

# A poor (but adequate) look up Hash based on Z position
map = Hash.new { |h, k| h[k] = [] }
bricks.each do |brick|
  (brick.first.last..brick.last.last).each do |z|
    map[z] << brick
  end
end

bricks.each do |from, to|
  while from[2] != 1
    spec_brick = [from.clone, to.clone]
    spec_brick[0][2] -= 1
    spec_brick[1][2] -= 1

    z1 = from[2]
    z2 = to[2]

    # Detect for any blocking brick at z - 1
    break if map[z1 - 1].any? { |other| intersect?(spec_brick, other) }

    # Move it down
    from[2] -= 1
    to[2]   -= 1

    # Update the Z position Hash
    (z1..z2).each {
      map[_1].delete([from, to])
      map[_1 - 1] << [from, to]
    }
  end
end

bricks.sort_by! { |from, to| [from.last, to.last].min }

require 'set'
sole_supports = Set.new

above = Hash.new { |h, k| h[k] = [] }
below = {}

bricks.each.with_index { |(from, to), bidx|
  spec_brick = [from.clone, to.clone]
  spec_brick[0][2] -= 1
  spec_brick[1][2] -= 1

  # List of bricks supporting the current brick
  supports = bricks.map.with_index
    .select { |other, _| intersect?(spec_brick, other) }
    .reject { |other, _| [from, to] == other }

  supports.map(&:last).each {
    above[_1] << bidx
  }
  below[bidx] = supports.map(&:last)

  if supports.count == 1
    sole_supports << supports.first.last
  end
}

# Part 1
pp bricks.count - sole_supports.count

# Part 2
sole_supports.sum { |idx|
  fell = Set.new
  fell << idx

  candidates = Set.new

  above[idx].each { candidates << _1 }

  falling = true
  while falling
    falling = false

    # to_a to allow modification of candidates while iterating through it
    candidates.to_a.each { |candidate|
      # Check if this candidate has all their supports removed
      if below[candidate].all? { fell.include?(_1) }
        candidates.delete(candidate)
        fell << candidate
        above[candidate].each { candidates << _1 }
        falling = true
        break
      end
    }
  end

  # Less the brick that was removed
  fell.count - 1
}.tap { puts _1 }
