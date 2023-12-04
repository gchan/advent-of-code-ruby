#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

numbers = {}

lines = input.each_line.to_a.map(&:strip)

lines.each_with_index do |line, y|
  line.scan(/\d+/) do
    numbers[[Regexp.last_match.begin(0), y]] = _1
  end
end

numbers.sum { |(x, y), num|
  min_x = [x - 1, 0].max
  min_y = [y - 1, 0].max

  max_x = x + num.length
  max_y = y + 1

  lines[min_y..max_y]
    .map { _1[min_x..max_x] }
    .join
    .match?(/[^\d\.]/)
    .then { _1 ? num.to_i : 0 }
}
.tap { puts _1 }

