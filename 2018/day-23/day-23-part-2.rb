#!/usr/bin/env ruby

# Part 2 was tricky, needed to investigate solutions on Reddit

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

  def intersect?(xr, yr, zr)
    distance_to_edge(x, xr.first, xr.last) +
      distance_to_edge(y, yr.first, yr.last) +
      distance_to_edge(z, zr.first, zr.last) <= r
  end

  def distance_to_edge(a, min, max)
    if a >= min && a < max
      0
    elsif a < min
      min - a
    else
      a - max + 1
    end
  end
end

class Cube
  attr_reader :x, :y, :z, :count

  def initialize(x, y, z, count = nil)
    @x = x
    @y = y
    @z = z
    @count = count
  end

  def divide
    x_mid = (x.last + x.first) / 2

    x0 = x.first..x_mid
    x1 = x_mid..x.last

    y_mid = (y.last + y.first) / 2

    y0 = y.first..y_mid
    y1 = y_mid..y.last

    z_mid = (z.last + z.first) / 2

    z0 = z.first..z_mid
    z1 = z_mid..z.last

    [[x0, x1], [y0, y1], [z0, z1]]
      .inject(&:product).map(&:flatten)
  end

  def size
    x.size - 1
  end
end

bots.map! do |bot|
  x, y, z, r = bot.scan(/-*\d+/).map(&:to_i)

  Bot.new(x, y, z, r)
end

x = Range.new *bots.map(&:x).minmax
y = Range.new *bots.map(&:y).minmax
z = Range.new *bots.map(&:z).minmax

max_range = [x, y, z].sort_by(&:size).last

cube_width = (max_range.size.to_f ** 0.5).ceil ** 2

range = (-cube_width / 2)..(cube_width / 2)

cube = Cube.new(range, range, range, bots.size)

queue = [cube]

best = nil

# 1. Split search space into 8 cubes
# 2. Continue spliting each cube into smaller cubes
# 3. Priortise cubes with the greatest number of bots
# 4. A solution is reached when a cube is broken into 8 x, y, z
# positions. The position with greatest number of bots is the
# solution. (prioritise position closest to origin)
while queue.any?
  queue = queue.sort_by(&:count).reverse
  cube = queue.shift

  break if best && cube.count < best.count

  if cube.size == 1
    best = cube if best.nil? || cube.count > best.count
  else
    cube.divide.map do |x, y, z|
      count = bots.count { |bot| bot.intersect?(x,y,z) }

      queue << Cube.new(x, y, z, count)
    end
  end
end

puts best.x.first + best.y.first + best.z.first
puts best.count
