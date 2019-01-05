#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input = File.read(file_path)

constellations = []

points = input.split("\n").map do |line|
  line.split(",").map(&:to_i)
end

def distance(point, other)
  point.zip(other)
    .map { |(p1, p2)| (p1 - p2).abs }
    .inject(:+)
end

points.each do |point|
  matches = constellations.select do |constellation|
    constellation.any? { |other_point| distance(point, other_point) <= 3 }
  end

  case matches.count
  when 0
    constellations << [point]
  when 1
    matches.first << point
  else
    matches.each { |constellation| constellations.delete(constellation) }
    constellation = matches.inject(&:concat) << point
    constellations << constellation
  end
end

puts constellations.count
