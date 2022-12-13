#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

hx = hy = 0
tx = ty = 0

visited = [[tx, ty]].to_set

input.each_line do |line|
  dir, v = line.split
  v = v.to_i

  v.times do
    case dir
    when "R"
      hx += 1
    when "L"
      hx -= 1
    when "U"
      hy += 1
    when "D"
      hy -= 1
    end

    # neighbour check
    next if (hx - tx).abs <= 1 && (hy - ty).abs <= 1

    if hy != ty
      ty += (hy - ty).positive? ? 1 : -1
    end

    if hx != tx
      tx += (hx - tx).positive? ? 1 : -1
    end

    visited << [tx, ty]
  end
end

puts visited.count
