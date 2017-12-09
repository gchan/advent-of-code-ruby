#!/usr/bin/env ruby

# Identical to Part 1

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

instructions = input.split("\n")

registers = Hash.new(0)
max_value = 0

instructions.each do |instruction|
  reg, cmd, amount, _, con_reg, con, con_val =
    instruction.split(" ")

  amount = amount.to_i
  con_val = con_val.to_i

  if registers[con_reg].send(con, con_val)
    if cmd == 'inc'
      registers[reg] += amount
    else
      registers[reg] -= amount
    end
  end

  max_value = [registers[reg], max_value].max
end

puts registers.values.max
puts max_value
