#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.each_line.map { _1.strip.chars }

# Tilt left
def tilt(grid)
  grid.map do |row|
    row
      .join
      .split(?#)
      .map { |section|
        count = section.chars.count { _1 == ?O }

        ?O * count + ?. * (section.length - count)
      }
      .join(?#)
      .ljust(row.length, ?#)
      .chars
  end
end

def cycle(grid)
  # north, west, south, east
  grid
    .then { tilt(_1.transpose).transpose }
    .then { tilt(_1) }
    .then { tilt(_1.transpose.map(&:reverse)).map(&:reverse).transpose }
    .then { tilt(_1.map(&:reverse)).map(&:reverse) }
end

CYCLES = 1_000_000_000

states = Hash.new { |h, k| h[k] = [] }

CYCLES.times do |idx|
  grid = cycle(grid)

  state = grid.map(&:join).join("\n")
  states[state] << idx

  # Identify a loop
  if states[state].count > 1
    cycle = states[state][-1] - states[state][-2]

    # Is this the 1 billionth state?
    break if (CYCLES - idx - 1) % cycle == 0
  end
end

grid
  .map { |row| row.count { _1 == ?O } }
  .each_with_index
  .sum { |count, idx| count * (grid.length - idx) }
  .tap { puts _1 }
