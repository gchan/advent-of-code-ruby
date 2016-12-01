#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

# Could be better
input.chars.each_with_index.inject(0) do |floor, (character, index)|
  if character == "("
    floor += 1
  else
    floor -= 1
  end

  if floor < 0
    puts index + 1
    break
  end

  floor
end
