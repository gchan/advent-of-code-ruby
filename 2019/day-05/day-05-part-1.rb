#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

codes = input.split(",").map(&:to_i)
inp = 1

i = 0

loop do
  opcode = codes[i] % 100

  modes = (codes[i] / 100).digits
  3.times { modes << 0 }

  refs = modes.map.with_index do |m, idx|
    address = i + idx + 1

    if m == 1
      address
    else
      codes[address]
    end
  end

  case opcode
  when 1
    op = :+
  when 2
    op = :*
  when 3
    codes[refs[0]] = inp
  when 4
    puts codes[refs[0]]
  when 99
    exit
  end

  codes[refs[2]] = codes[refs[0]].send(op, codes[refs[1]]) if op

  if [1, 2].include?(opcode)
    i += 4
  else
    i += 2
  end
end
