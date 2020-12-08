#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path('day-08-input.txt', __dir__)
input     = File.read(file_path)

ops = input.split("\n")

i = 0
acc = 0
executed = Set.new

while true
  if executed.include?(i)
    puts acc
    exit
  end

  executed.add(i)

  op, arg = ops[i].split
  arg = arg.to_i

  case op
  when "acc"
    acc += arg
  when "jmp"
    i += arg - 1
  end

  i += 1
end
