#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

instructions = input.split("\n")

reg = Hash.new { |hash, key| hash[key] = 0 }

i = 0

while i < instructions.length
  cmd, arg1, arg2 = instructions[i].split(" ")

  if arg1 =~ /\d/
    val = arg1.to_i
  else
    val = reg[arg1]
  end

  case cmd
  when 'cpy'
    reg[arg2] = val
  when 'jnz'
    if val != 0
      i += arg2.to_i
      next
    end
  when 'inc'
    reg[arg1] += 1
  when 'dec'
    reg[arg1] -= 1
  end

  i += 1
end

puts reg['a']
