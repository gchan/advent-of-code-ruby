#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

codes = input.split(",").map(&:to_i)

codes[1] = 12
codes[2] = 2

i = 0

loop do
  case codes[i]
  when 1
    op = :+
  when 2
    op = :*
  when 99
    puts codes[0]
    exit
  end

  codes[codes[i+3]] = codes[codes[i+1]].send(op, codes[codes[i+2]])

  i += 4
end
