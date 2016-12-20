#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

class Elf
  attr_reader :number
  attr_accessor :next_elf

  def initialize(number)
    @number = number
  end
end

elf_count = input.to_i

first_elf = Elf.new(1)
previous_elf = first_elf

(elf_count - 1).times do |i|
  current_elf = Elf.new(i + 2)
  previous_elf.next_elf = current_elf
  previous_elf = current_elf
end

previous_elf.next_elf = first_elf

current_elf = first_elf

while elf_count != 1 do
  current_elf.next_elf = current_elf.next_elf.next_elf
  elf_count -= 1
  current_elf = current_elf.next_elf
end

puts current_elf.number
