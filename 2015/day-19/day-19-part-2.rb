#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.readlines(file_path)

molecule     = input.pop(2).last
replacements = {}

input.each do |replacement|
  element     = replacement.scan(/\A\w*/).first
  new_element = replacement.strip.scan(/\w*\z/).first

  replacements[new_element] = element
end

# Brute force by randomly performing replacements
molecule_dup = molecule.dup
while !molecule_dup.match(/e+/)
  steps        = 0
  molecule_dup = molecule.dup
  exhausted    = false

  # Keep on trying until we run out of replacement options
  while !exhausted
    exhausted = true

    replacements.keys.shuffle.each do |element|
      if molecule_dup.scan(element).any?
        molecule_dup.sub!(element, replacements[element])
        steps     += 1
        exhausted = false
        break
      end
    end
  end
end

puts steps
