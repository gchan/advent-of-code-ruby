#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

registers, commands = input.split("\n\n")

reg = registers.scan(/\d+/).map(&:to_i)
cmds = commands.scan(/\d+/).map(&:to_i)

out = []

ptr = 0

while ptr < cmds.length
  cmd, op = cmds[ptr], cmds[ptr + 1]

  lit = op
  co = op
  if op >= 4 && op<= 6
    co = reg[op - 4]
  end

  case cmd
  when 0
    reg[0] = reg[0] / (2**co)
  when 1
    reg[1] = reg[1] ^ lit
  when 2
    # keep last 3 bits
    reg[1] = co % 8
  when 3
    if reg[0] != 0 && lit != ptr
      ptr = lit
      next
    end
  when 4
    reg[1] = reg[1] ^ reg[2]
  when 5
    out << co % 8
  when 6
    reg[1] = reg[0] / (2**co)
  when 7
    reg[2] = reg[0] / (2**co)
  end

  ptr += 2
end

puts out.join(?,)
