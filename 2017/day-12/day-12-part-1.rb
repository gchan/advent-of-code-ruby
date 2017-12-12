#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

programs = Hash.new { |h,k| h[k] = [] }

input.split("\n").each do |line|
  from, *to = line.split(/<->|,/).map(&:to_i)
  programs[from].concat to
end

queue = [0]
group = Set.new

while queue.any?
  pg = queue.pop
  group.add(pg)

  queue += programs[pg].reject { |pro| group.include?(pro) }
end

puts group.size
