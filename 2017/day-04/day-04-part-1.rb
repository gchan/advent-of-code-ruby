#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n").count { |pw|
  pw.split(" ").uniq.length == pw.split(" ").length
}
