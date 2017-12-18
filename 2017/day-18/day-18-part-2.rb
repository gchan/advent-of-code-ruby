#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

insts = input.split("\n")

def run(idx, r, insts, in_q, out_q)
  until idx >= insts.length
    cmd, x, y = insts[idx].split(" ")

    y = y =~ /\d/ ? y.to_i : r[y]

    case cmd
    when 'snd'
      out_q << r[x]
    when 'set'
      r[x] = y
    when 'add'
      r[x] += y
    when 'mul'
      r[x] *= y
    when 'mod'
      r[x] %= y
    when 'rcv'
      return idx if in_q.size == 0
      r[x] = in_q.shift
    when 'jgz'
      x = x =~ /\d/ ? x.to_i : r[x]
      idx += (y - 1) if x > 0
    end

    idx += 1
  end

  -1
end

r1 = { 'p' => 0 }
r2 = { 'p' => 1 }

p1q = []
p2q = []

j = 0
k = 0

sent = 0

while true
  j = run(j, r1, insts, p1q, p2q) if j != -1
  k = run(k, r2, insts, p2q, p1q) if k != -1

  sent += p1q.size

  break if j == -1 && k == -1
  break if p1q.size == 0 && p2q.size == 0
end

puts sent
