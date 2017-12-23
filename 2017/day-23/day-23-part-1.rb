#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input = File.read(file_path)

reg = Hash.new(0)

cmds = input.split("\n")
idx = 0
count = 0

until idx >= cmds.length
  a, b, c = cmds[idx].split(" ")

  if c =~ /\d/
    c = c.to_i
  else
    c = reg[c]
  end

  case a
  when 'set'
    reg[b] = c
  when 'sub'
    reg[b] -= c
  when 'mul'
    reg[b] *= c
    count += 1
  when 'jnz'
    b = b =~ /\d/ ? b.to_i : reg[b]
    idx += (c - 1) if b != 0
  end

  idx += 1
end

puts count