#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

class Cpu
  attr_reader :x, :cycle

  def initialize
    @x = 1
    @cycle = 0
  end

  def tick
    @cycle += 1

    draw
  end

  def add(i)
    @x += i
  end

  private

  def draw
    print lit_pixel? ? "#" : "."

    puts if cycle % 40 == 0
  end

  def lit_pixel?
    pixel = cycle % 40

    pixel >= x && pixel < x + 3
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

