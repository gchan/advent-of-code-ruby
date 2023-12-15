#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

input
  .strip
  .split(",")
  .sum {
    _1.chars.inject(0) { |val, chr|
      val += chr.ord
      val *= 17
      val %= 256
    }
  }
  .tap { puts _1 }
