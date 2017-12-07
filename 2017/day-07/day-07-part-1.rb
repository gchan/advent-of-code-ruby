#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

programs = input.split("\n")

parents = []
children = []

programs.each do |disc|
  next unless disc.include?("->")

  parents << disc.split(" ").first
  children += disc.split("->").last.gsub!(",", "").split(" ")
end

puts parents - children
