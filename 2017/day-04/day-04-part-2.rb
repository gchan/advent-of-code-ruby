#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n").count { |pw|
  words = pw.split(" ").map { |word| word.chars.sort.join }

  words.uniq.length == words.length
}
