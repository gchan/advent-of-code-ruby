#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

orbits = {}

input.split("\n").each do |orbit|
  a, b = orbit.split(")")

  orbits[b] = a
end

count = 0

orbits.each do |obj, _|
  while orbits[obj]
    obj = orbits[obj]
    count += 1
  end
end

puts count
