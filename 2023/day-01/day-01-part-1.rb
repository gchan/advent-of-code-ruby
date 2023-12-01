#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

input
  .split("\n")
  .sum { _1.scan(/\d/).values_at(0, -1).join.to_i }
  .tap { puts _1 }
