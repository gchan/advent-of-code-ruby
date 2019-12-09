#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path).strip

codes = Hash.new(0)

input.split(",").each_with_index do |code, i|
  codes[i] = code.to_i
end

relative_base = 0
inp = 2

i = 0

loop do
  opcode = codes[i] % 100

  modes = (codes[i] / 100).digits
  3.times { modes << 0 }

  refs = modes.map.with_index do |m, idx|
    address = i + idx + 1

    if m == 1
      address
    elsif m == 2
      relative_base + codes[address]
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
  when 5
    if codes[refs[0]] != 0
      i = codes[refs[1]]
      next
    end
  when 6
    if codes[refs[0]] == 0
      i = codes[refs[1]]
      next
    end
  when 7
    if codes[refs[0]] < codes[refs[1]]
      codes[refs[2]] = 1
    else
      codes[refs[2]] = 0
    end
  when 8
    if codes[refs[0]] == codes[refs[1]]
      codes[refs[2]] = 1
    else
      codes[refs[2]] = 0
    end
  when 9
    relative_base += codes[refs[0]]
  when 99
    exit
  end

  codes[refs[2]] = codes[refs[0]].send(op, codes[refs[1]]) if op

  if [1, 2, 7, 8].include?(opcode)
    i += 4
  elsif [5, 6].include?(opcode)
    i += 3
  else
    i += 2
  end
end
