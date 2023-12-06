#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

times, distances = input.split("\n")

times = times.scan(/\d+/).map(&:to_i)
distances = distances.scan(/\d+/).map(&:to_i)

times.zip(distances)
  .map { |time, record|
    time.times.count { _1 * (time - _1) > record }
  }
  .inject(:*)
  .tap { puts _1 }
