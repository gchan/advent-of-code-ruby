#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input = File.read(file_path)

class Particle
  attr_accessor :p, :v, :a, :i

  def initialize(pva, i)
    @i = i
    @p, @v, @a = *pva
  end

  def tick
    @v = v.zip(a).map { |v, a| v + a }
    @p = p.zip(v).map { |p, v| p + v }
  end
end

particles = input.split("\n").map.with_index do |part, i|
  pva = part.split('>,').map do |vec|
    vec.scan(/-*\d+/).to_a.map(&:to_i)
  end

  Particle.new(pva, i)
end

counts = []

while true
  particles.each(&:tick)

  particles.product(particles).each do |p, o|
    next if o == p || p.p != o.p
    particles.delete(p)
    particles.delete(o)
  end

  puts particles.size
  counts << particles.size

  break if counts.size > 9 && counts[-9..-1].uniq.size == 1
end
