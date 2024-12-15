#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

count = 0

rows = input.split.map(&:chars)

rows[0..-3].each.with_index do |row, y|
  row[0..-3].each.with_index do |_, x|
    next unless rows[y + 1][x + 1] == ?A

    next if rows[y][x, 3].rotate(-1)[0..1]
      .zip(
        rows[y + 2][x, 3].rotate(-1)[0..1].reverse
      )
      .map(&:sort)
      .any? { _1 != [?M, ?S] }

    count += 1
  end
end

puts count
