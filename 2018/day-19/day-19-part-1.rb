#!/usr/bin/env ruby

# Includes solution for part 2

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

def operation(reg, op, a, b, c)
  case op
  when 'addr'
    reg[c] = reg[a] + reg[b]
  when 'addi'
    reg[c] = reg[a] + b
  when 'mulr'
    reg[c] = reg[a] * reg[b]
  when 'muli'
    reg[c] = reg[a] * b
  when 'banr'
    reg[c] = reg[a] & reg[b]
  when 'bani'
    reg[c] = reg[a] & b
  when 'boor'
    reg[c] = reg[a] | reg[b]
  when 'bori'
    reg[c] = reg[a] | b
  when 'setr'
    reg[c] = reg[a]
  when 'seti'
    reg[c] = a
  when 'gtir'
    reg[c] = a > reg[b] ? 1 : 0
  when 'gtri'
    reg[c] = reg[a] > b ? 1 : 0
  when 'gtrr'
    reg[c] = reg[a] > reg[b] ? 1 : 0
  when 'eqir'
    reg[c] = a == reg[b] ? 1 : 0
  when 'eqri'
    reg[c] = reg[a] == b ? 1 : 0
  when 'eqrr'
    reg[c] = reg[a] == reg[b] ? 1 : 0
  end

  reg
end

reg = [0, 0, 0, 0, 0, 0]

instructions = input.split("\n")

pointer = instructions.shift.scan(/\d+/)[0].to_i

instructions = instructions.map do |instruction|
  op, *val = instruction.split(" ")
  a, b, c = val.map(&:to_i)

  [op, a, b, c]
end

while reg[pointer] >= 0 && reg[pointer] < instructions.size
  op, a, b, c = instructions[reg[pointer]]

  reg = operation(reg, op, a, b, c)
  reg[pointer] += 1
end

puts reg[0]
