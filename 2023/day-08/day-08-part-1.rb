#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

steps, map = input.split("\n\n")

steps = steps.chars

network = {}

map.each_line {
  from, *dest = _1.scan(/\w+/)
  network[from] = dest
}

i = 0
curr = "AAA"

while curr != "ZZZ"
  step = steps[i % (steps.length)]

  dir = step == ?L ? 0 : 1
  curr = network[curr][dir]

  i += 1
end

puts i
