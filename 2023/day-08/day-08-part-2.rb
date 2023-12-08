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

starts = network.keys.select { _1 =~ /A$/ }

starts
  .map { |curr|
    i = 0

    while !curr.match?(/Z$/)
      step = steps[i % (steps.length)]

      dir = step == ?L ? 0 : 1
      curr = network[curr][dir]

      i += 1
    end

    i
  }
  .inject(:lcm)
  .tap { puts _1 }
