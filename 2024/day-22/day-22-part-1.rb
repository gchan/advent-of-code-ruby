#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

input.split.map(&:to_i)
  .sum {
    s = _1

    2000.times {
      s = s.*(64).^(s).%(16777216)
      s = s./(32).^(s).%(16777216)
      s = s.*(2048).^(s).%(16777216)
    }

    s
  }
  .tap { p _1 }
