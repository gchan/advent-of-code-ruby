#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

class Moon
  attr_accessor :x, :y, :z, :x1, :y1, :z1

  def initialize(x,y,z)
     @x = x
     @y = y
     @z = z
     @x1 = @y1 = @z1 = 0
  end
end

moons = []

input.split("\n").each do |line|
  moons << Moon.new(*line.scan(/-*\d+/).map(&:to_i))
end

1000.times do
  moons.each do |moon|
    moons.each do |moon2|
      [:x, :y, :z].each do |axis|
        m_pos = moon.send(axis)
        m2_pos = moon2.send(axis)

        if m_pos < m2_pos
          moon.send("#{axis}1=", moon.send("#{axis}1") + 1)
        elsif m_pos > m2_pos
          moon.send("#{axis}1=", moon.send("#{axis}1") - 1)
        end
      end
    end
  end

  moons.each do |moon|
    [:x, :y, :z].each do |axis|
      moon.send("#{axis}=", moon.send(axis) + moon.send("#{axis}1"))
    end
  end
end

total = 0

moons.each do |moon|
  pot = 0
  kin = 0

  [:x, :y, :z].each do |axis|
    pot += moon.send(axis).abs
    kin += moon.send("#{axis}1").abs
  end

  total += pot * kin
end

puts total
