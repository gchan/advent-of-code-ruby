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

grid
  .then { tilt(_1.transpose).transpose }
  .map { |row| row.count { _1 == ?O } }
  .each_with_index
  .sum { |count, idx| count * (grid.length - idx) }
  .tap { puts _1 }
