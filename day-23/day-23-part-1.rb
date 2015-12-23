#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.readlines(file_path)

class Instruction
  attr_reader :name, :register, :offset

  def initialize(name, register, offset)
    @name     = name
    @register = register
    @offset   = offset
  end
end

instructions = input.map do |instruction|
  components = instruction.sub(",", "").split
  name = components.first.to_sym

  if components.length == 3
    register = components[1].to_sym
    offset   = components[2].to_i
  else # == 2
    if name == :jmp
      offset = components[1].to_i
    else
      register = components[1].to_sym
    end
  end

  Instruction.new(name, register, offset)
end

registers = Hash.new(0)

next_instruction = 0

while instruction = instructions[next_instruction]
  case instruction.name
  when :hlf
    registers[instruction.register] /= 2
    next_instruction += 1
  when :tpl
    registers[instruction.register] *= 3
    next_instruction += 1
  when :inc
    registers[instruction.register] += 1
    next_instruction += 1
  when :jmp
    next_instruction += instruction.offset
  when :jie
    if registers[instruction.register].even?
      next_instruction += instruction.offset
    else
      next_instruction += 1
    end
  when :jio
    if registers[instruction.register] == 1
      next_instruction += instruction.offset
    else
      next_instruction += 1
    end
  end
end

puts registers[:b]
