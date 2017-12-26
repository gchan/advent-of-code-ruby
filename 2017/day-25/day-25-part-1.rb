#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input = File.read(file_path)

lines = input.split("\n")

instructions = {}

((lines.length - 2) / 10).times do |i|
  state_lines = lines[3 + 10 * i, 9]

  instr = [state_lines[2, 3], state_lines[6, 3]].map do |lines|
    {
      write: lines[0][/\d+/].to_i,
      dir:   lines[1][/(left|right)/],
      state: lines[2][/(\w)\./][0]
    }
  end

  state = state_lines[0][/(\w):/][0]

  instructions[state] = [0, 1].zip(instr).to_h
end

tape = [0]
idx = 0
state = lines[0][/(\w)\./][0]
steps = lines[1][/\d+/].to_i

steps.times do
  instr = instructions[state][tape[idx]]

  tape[idx] = instr[:write]

  if instr[:dir] == "right"
    idx += 1
  else
    idx -= 1
  end

  if idx < 0
    tape.unshift 0
    idx += 1
  elsif idx == tape.size
    tape.push 0
  end

  state = instr[:state]
end

puts tape.count { |b| b == 1 }
