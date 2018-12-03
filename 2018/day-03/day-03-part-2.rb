#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

grid = Array.new(1000) { Array.new(1000) { Set.new } }
candidates = Set.new

claims = input.split("\n")

claims.each do |claim|
  id, claim = claim.split("@")
  ord, dim = claim.split(":")
  x, y = ord.split(",").map(&:to_i)
  w, h = dim.split("x").map(&:to_i)
  id = id[1..-1].to_i

  candidates.add id

  w.times do |x1|
    h.times do |y1|
      cell = grid[x+x1][y+y1]

      if cell.any?
        candidates.delete id

        cell.each do |c|
          candidates.delete c
        end
      end

      cell.add id
    end
  end
end

puts candidates.to_a
