#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input = File.read(file_path)

bots = input.split("\n")

class Bot
  attr_reader :x, :y, :z, :r

  def initialize(x, y, z, r)
    @x = x
    @y = y
    @z = z
    @r = r
  end

  def distance(other)
    (other.x - x).abs +
    (other.y - y).abs +
    (other.z - z).abs
  end

  def within_range?(other)
    distance(other) <= r
  end
end

bots.map! do |bot|
  x, y, z, r = bot.scan(/-*\d+/).map(&:to_i)

  Bot.new(x, y, z, r)
end

puts bots.map { |bot|
  bots.count { |other| bot.within_range?(other) }
}.max
