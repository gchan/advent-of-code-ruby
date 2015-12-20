#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.readlines(file_path)

molecule     = input.pop(2).last
replacements = Hash.new { |h, k| h[k] = [] }

input.each do |replacement|
  element     = replacement.scan(/\A\w*/).first
  new_element = replacement.strip.scan(/\w*\z/).first

  replacements[element] << new_element
end

new_molecules = Set.new

# Could be cleaner
molecule.length.times do |index|
  element = molecule[index]
  next if element.match(/[a-z]/)

  second_char = molecule[index + 1]
  if second_char && second_char.match(/[a-z]/)
    element += second_char
  end

  replacements[element].each do |replacement|
    new_molecule = molecule.dup
    new_molecule.slice!(index, element.length)
    new_molecules.add new_molecule.insert(index, replacement)
  end
end

puts new_molecules.count
