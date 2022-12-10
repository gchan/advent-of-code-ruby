#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

_, idx = input.chars.each_cons(14).with_index.find { |seq, idx|
  seq.uniq.count == 14
}

puts idx + 14
