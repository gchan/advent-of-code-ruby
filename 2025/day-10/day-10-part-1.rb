#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

machines = input.split("\n").map { _1.split(/(?<=\]) | (?=\{)/) }
  .map! { |lights, buttons, _joltage|
    lights = lights.chars[1...-1].map { _1 == "#" ? 1 : 0 }

    buttons = buttons
      .scan(/
        \(          # Opening parenthesis
        (\d[,\d+]*) # One or more digits separated by commas
        \)          # Closing parenthesis
        /x)
      .flatten
      .map { _1.split(",").map(&:to_i) }

    [lights, buttons]
  }

machines
  .map { |lights, buttons|
    # BFS
    queue = [[Array.new(lights.size, 0), 0]]
    visited = Set.new

    until queue.empty?
      state, presses = queue.shift

      next if visited.include?(state)
      visited.add(state)

      if state == lights
        count = presses
        break
      end

      buttons.each do |button|
        new_state = state.dup
        button.each { |pos| new_state[pos] ^= 1 }

        queue << [new_state, presses + 1]
      end
    end

    count
  }
  .sum
  .tap { puts _1 }
