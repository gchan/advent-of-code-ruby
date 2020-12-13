#!/usr/bin/env ruby

file_path = File.expand_path('day-13-input.txt', __dir__)
input     = File.read(file_path)

earliest, buses = input.split("\n")

earliest = earliest.to_i
buses = buses.split(",").reject { |id| id == ?x }.map(&:to_i)

depart, id = buses.map { |id|
  [
    (earliest.to_f / id).ceil * id,
    id
  ]
}.min

puts (depart - earliest) * id
