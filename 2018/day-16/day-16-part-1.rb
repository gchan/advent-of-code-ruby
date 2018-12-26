#!/usr/bin/env ruby

# Includes solution for part 2

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

samples = input.split(/\n{2,3}/)
instructions = samples.pop.split("\n")

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

ops = %w(addr addi mulr muli banr bani boor bori setr seti gtir gtri
  gtrr eqir eqri eqrr)

possible_codes = []

count = 0

samples.each do |sample|
  before, instr, after = sample.split("\n")

  before = before.scan(/\[(.*)\]/).flatten.first.split(",").map(&:to_i)
  after = after.scan(/\[(.*)\]/).flatten.first.split(",").map(&:to_i)

  code, a, b, c = instr.split(" ").map(&:to_i)

  matches = 0
  matching_ops = []

  ops.each do |op|
    output = operation(before.clone, op, a, b, c)

    if output == after
      matches += 1
      matching_ops << op
    end
  end

  if possible_codes[code].nil?
    possible_codes[code] = matching_ops
  else
    possible_codes[code] &= matching_ops
  end

  count += 1 if matches >= 3
end

puts count # part 1 solution

# Depth-first search
# Didn't needed to do this as there was an opcode with only one possibility
def find_solution(possibilities, *rest)
  return [possibilities.first] if rest.empty?

  possibilities.each do |inst|
    copy = rest.map(&:clone)

    copy.each { |instrs| instrs.delete(inst) }

    codes = [inst].concat(find_solution(*copy))

    return codes if codes.none?(&:nil?)
  end

  [nil]
end

op_codes = find_solution(*possible_codes)

reg = [0, 0, 0, 0]

instructions.each do |instruction|
  op_code, a, b, c = instruction.split(" ").map(&:to_i)
  next if op_code.nil?
  reg = operation(reg, op_codes[op_code], a, b, c)
end

puts reg[0] # part 2 solution
