#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

class Cpu
  attr_reader :x, :cycle, :signal_sum

  def initialize
    @x = 1
    @cycle = 0
    @signal_sum = 0
  end

  def tick
    @cycle += 1

    if (cycle - 20) % 40 == 0
      @signal_sum += cycle * x
    end
  end

  def add(i)
    @x += i
  end
end

cpu = Cpu.new

input.each_line do |line|
  case line.strip.split
  in ["addx", add]
    cpu.tick
    cpu.tick
    cpu.add(add.to_i)
  in ["noop"]
    cpu.tick
  end
end

puts cpu.signal_sum

