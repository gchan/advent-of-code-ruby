#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

RED = 12
GREEN = 13
BLUE = 14

input
  .each_line
  .sum {
    blue  = _1.scan(/(\d+) b/).flatten.map(&:to_i).max
    red   = _1.scan(/(\d+) r/).flatten.map(&:to_i).max
    green = _1.scan(/(\d+) g/).flatten.map(&:to_i).max

    if blue > BLUE || red > RED || green > GREEN
      0
    else
      _1.scan(/Game (\d*)/).flatten.first.to_i
    end
  }
  .tap { puts _1 }
