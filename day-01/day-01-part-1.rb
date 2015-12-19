#!/usr/bin/env ruby

file_path = File.expand_path("../day-1-input.txt", __FILE__)
input     = File.read(file_path)

up   = input.scan(/\(/).count
down = input.scan(/\)/).count

floor = up - down

puts floor
