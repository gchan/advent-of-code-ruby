#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

insts = input.split("\n")

r = Hash.new(0)
freq = 0
idx = 0

until idx >= insts.length
  cmd, x, y = insts[idx].split(" ")

  y = y =~ /\d/ ? y.to_i : r[y]

  case cmd
  when 'snd'
    freq = r[x]
  when 'set'
    r[x] = y
  when 'add'
    r[x] += y
  when 'mul'
    r[x] *= y
  when 'mod'
    r[x] %= y
  when 'rcv'
    break if r[x] != 0
  when 'jgz'
    idx += (y - 1) if r[x] > 0
  end

  idx += 1
end

puts freq
