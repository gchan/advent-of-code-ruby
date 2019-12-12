#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

require 'set'

class Moon
  attr_accessor :x, :y, :z, :x1, :y1, :z1

  def initialize(x,y,z)
     @x = x
     @y = y
     @z = z
     @x1 = @y1 = @z1 = 0
  end

  def axis(axis)
    [send(axis), send("#{axis}1")]
  end
end

moons = []

input.split("\n").each do |line|
  moons << Moon.new(*line.scan(/-*\d+/).map(&:to_i))
end

loops ={}
visited = {}

[:x, :y, :z].each do |axis|
  visited[axis] = Set.new
  visited[axis].add(moons.map { |moon| moon.axis(axis) }.flatten)
end

i = 1

while true
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

  [:x, :y, :z].each do |axis|
    state = moons.map { |moon| moon.axis(axis) }.flatten
    if visited[axis].include? state
      loops[axis] = i if loops[axis].nil?
    else
      visited[axis].add(state)
    end
  end

  if loops.count == 3
    puts loops.inspect
    puts loops.values.reduce(:lcm)
    break
  end

  i += 1
end
