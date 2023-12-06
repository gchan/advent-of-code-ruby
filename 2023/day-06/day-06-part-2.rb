#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

time, distance = input.split("\n")

time = time.scan(/\d+/).join.to_i
record = distance.scan(/\d+/).join.to_i

time.times
  .count { _1 * (time - _1) > record }
  .tap { puts _1 }

