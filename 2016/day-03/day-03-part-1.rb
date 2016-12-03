#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

triangles = input.split("\n").map { |triangle| triangle.split.map(&:to_i).sort }

puts triangles.count { |sides| sides[0] + sides[1] > sides[2] }
