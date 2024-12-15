#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

regex = /XMAS/

count = 0

count += input.scan(regex).count
count += input.reverse.scan(regex).count

rotated = input.split.map(&:chars)
  .transpose.map(&:join).join("\n")

count += rotated.scan(regex).count
count += rotated.reverse.scan(regex).count

rows = input.split.map(&:chars)

rows[0..-4].each.with_index do |row, y|
  row.each.with_index do |cell, x|
    if x <= row.length - 4
      str = cell + rows[y + 1][x + 1] + rows[y + 2][x + 2] + rows[y + 3][x + 3]

      count += 1 if str.match?(regex)
      count += 1 if str.reverse.match?(regex)
    end

    if x >= 4 - 1
      str = cell + rows[y + 1][x - 1] + rows[y + 2][x - 2] + rows[y + 3][x - 3]

      count += 1 if str.match?(regex)
      count += 1 if str.reverse.match?(regex)
    end
  end
end

puts count
