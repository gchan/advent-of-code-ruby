#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

message = Array.new(lines.first.length) {
  Hash.new { |h, k| h[k] = 0 }
}

lines.each do |line|
  line.chars.each.with_index do |char, index|
    message[index][char] += 1
  end
end

puts message.map { |chars|
  chars.sort_by { |char, count| count }.last.first
}.join
