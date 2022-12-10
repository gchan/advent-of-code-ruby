#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

puts input.each_line.count { |pair|
  pair = pair.strip.split(',')
    .map { |section| section.split('-').map(&:to_i) }
    .map { |section| Range.new(*section) }

  pair[0].cover?(pair[1]) || pair[1].cover?(pair[0])
}
