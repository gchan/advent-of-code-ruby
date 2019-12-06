#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

orbits = {}

input.split("\n").each do |orbit|
  a, b = orbit.split(")")

  orbits[b] = a
end

def path(orbits, from)
  path = []

  while orbits[from]
    from = orbits[from]
    path << from
  end

  path
end

you_path = path(orbits, "YOU")
santa_path = path(orbits, "SAN")

intersect = you_path.find do |obj|
  santa_path.include?(obj)
end

puts you_path.index(intersect) + santa_path.index(intersect)
