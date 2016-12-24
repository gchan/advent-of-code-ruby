#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")[2..-1]

Node = Struct.new(:x, :y, :size, :used, :avail)

nodes = lines.map do |line|
  x, y, size, used, avail = line.match(/x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T\s*(\d+)T/)[1..-1].map(&:to_i)

  Node.new(x, y, size, used, avail)
end

pairs = []

nodes.select { |node| node.used > 0 }.each do |node_one|
  nodes.
    reject { |node| node_one == node }.
    select { |node| node_one.used <= node.avail }.
    each { |node_two| pairs << [node_one, node_two] }
end

puts pairs.count
