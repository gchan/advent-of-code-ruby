#!/usr/bin/env ruby

# Includes Part 2

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

stream = input.chars

clean_stream = []
garbage_mode = false

garbage_count = 0

while stream.any?
  char = stream.shift

  if char == '!'
    stream.shift
  elsif char == '<'
    garbage_mode = true
  elsif garbage_mode
    if char == '>'
      garbage_mode = false
    else
      garbage_count += 1
    end
  elsif char == '{' || char == '}'
    clean_stream << char
  end
end

puts garbage_count

score = 0
level = 0

while clean_stream.any?
  if clean_stream.shift == '{'
    level += 1
    score += level
  else
    level -= 1
  end
end

puts score
