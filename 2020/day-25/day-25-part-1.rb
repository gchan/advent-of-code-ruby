#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input     = File.read(file_path)

card, door = input.split("\n").map(&:to_i)

def transform(value: 1, subject:, frequency: 1)
  frequency.times do
    value *= subject
    value %= 20201227
  end
  value
end

def identify_loop(subject)
  size = 0
  value = 1
  while value != subject
    value = transform(value: value, subject: 7)
    size += 1
  end

  size
end

loop1 = identify_loop(card)
loop2 = identify_loop(door)

puts transform(subject: door, frequency: loop1)
puts transform(subject: card, frequency: loop2)
