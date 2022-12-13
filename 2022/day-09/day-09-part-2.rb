#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

# Head knot is at index 0
knots = Array.new(10) { [0, 0] }

visited = [knots[-1].clone].to_set

input.each_line do |line|
  dir, v = line.split
  v = v.to_i

  head = knots[0]
  v.times do
    case dir
    when "R"
      head[0] += 1
    when "L"
      head[0] -= 1
    when "U"
      head[1] += 1
    when "D"
      head[1] -= 1
    end

    knots.each_cons(2) do |head, tail|
      # neighbour check
      next if (head[0] - tail[0]).abs <= 1 && (head[1] - tail[1]).abs <= 1

      if head[1] != tail[1]
        tail[1] += (head[1] - tail[1]).positive? ? 1 : -1
      end

      if head[0] != tail[0]
        tail[0] += (head[0] - tail[0]).positive? ? 1 : -1
      end
    end

    visited << knots[-1].clone
  end
end

puts visited.count
