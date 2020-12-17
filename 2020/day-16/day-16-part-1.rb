#!/usr/bin/env ruby

# Includes solutions to both part 1 and 2

file_path = File.expand_path('day-16-input.txt', __dir__)
input     = File.read(file_path)

ranges = {}

fields = input.scan(/([\w\s]*:.+)\n/).flatten

fields.each_with_index do |field|
  key = field.match(/(.*):/).captures[0]

  range_set = field.split(" or ").map do |range|
    range = range.scan(/\d+-\d+/)[0]
    Range.new(*range.split("-").map(&:to_i))
  end

  ranges[key] = range_set
end

nearby = input.match(/nearby tickets:\n([\d,\n]+)\n\n/).captures.first
nearby_tickets = nearby.split("\n").map do |ticket|
  ticket.split(?,).map(&:to_i)
end

invalid_values = nearby_tickets.flatten.select do |value|
  ranges.values.flatten.none? { |range| range.cover?(value) }
end

puts invalid_values.sum

# Part 2

valid_tickets = nearby_tickets.select do |nums|
  nums.all? { |value|
    ranges.values.flatten.any? { |range| range.cover?(value) }
  }
end

columns = valid_tickets.transpose

keys_per_col = columns.map do |col|
  ranges.keys.select { |key|
    col.all? { |value|
      ranges[key].any? { |range| range.cover?(value) }
    }
  }
end

# Map each key to a column index
key_to_col = {}

# Luckily this greedy approach works
while keys_per_col.any?(&:any?)
  keys_per_col.each_with_index do |col, idx|
    next if col.empty? || col.size > 1

    key = col.first
    key_to_col[key] = idx

    keys_per_col.each do |col|
      col.delete(key)
    end
  end
end

your_ticket = input.match(/your ticket:\n(\S+)/).captures.first
  .split(",").map(&:to_i)

puts ranges.keys
  .select { |key| key.include?("departure") }
  .map { |key| your_ticket[key_to_col[key]] }
  .inject(:*)
