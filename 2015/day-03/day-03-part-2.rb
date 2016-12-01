#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

class Santa
  attr_reader :x, :y, :homes

  def initialize
    @x = 0
    @y = 0
    @homes = Set.new
    deliver
  end

  def up
    @y -= 1
  end

  def down
    @y += 1
  end

  def right
    @x += 1
  end

  def left
    @x -= 1
  end

  def deliver
    homes.add("#{x},#{y}")
  end
end

real_santa = Santa.new
robo_santa = Santa.new

santas = [real_santa, robo_santa].cycle

input.chars.each do |direction|
  santa = santas.next

  case direction
  when '>'
    santa.right
  when '<'
    santa.left
  when '^'
    santa.up
  when 'v'
    santa.down
  end

  santa.deliver
end

all_homes = real_santa.homes.merge(robo_santa.homes)

puts all_homes.count

