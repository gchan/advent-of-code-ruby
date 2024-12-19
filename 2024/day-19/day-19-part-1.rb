#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

towels, designs = input.split("\n\n")

towels = Set.new(towels.split(?,).map(&:strip))
designs = designs.split("\n")

max_length = towels.map(&:size).max

designs.select {
  valid = false
  queue = [_1]

  while queue.any?
    design = queue.shift

    (0...[max_length, design.size].min).each do |length|
      target = design[0..length]

      if towels.include?(target)
        if target == design
          valid = true
          queue.clear
        else
          queue.unshift(design[length+1..])
        end
      end
    end
  end

  valid
}.tap { puts _1.count }
