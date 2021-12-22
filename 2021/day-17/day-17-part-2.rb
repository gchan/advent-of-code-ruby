#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

x1, x2, y1, y2 = input.scan(/x=([-\d]*)..([-\d]*), y=([-\d]*)..([-\d]*)/)
  .flatten.map(&:to_i)

# Viable Xs (ignoring Y)
#
xs = []

(1..x2).each do |xv|
  vel = xv
  current = xv
  step = 1

  min_step = nil
  max_step = nil

  while true
    if (x1..x2).cover?(current)
      min_step = step if min_step.nil?
      max_step = step
      max_step = nil if vel == 0
    end

    vel -= 1
    current += vel
    step += 1

    break if current > x2 || vel < 0
  end

  xs << [min_step..max_step, xv] if min_step
end

x_map = Hash.new { |h, k| h[k] = [] }

xs.each do |step_range, xv|
  x_map[step_range] << xv
end

# Viable Ys (ignoring X)
#
ys = []

(y1..500).each do |yv|
  vel = yv
  current = yv
  step = 1

  min_step = nil
  max_step = nil

  while true
    if (y1..y2).cover?(current)
      min_step = step if min_step.nil?
      may_step = step
      may_step = nil if vel == 0
    end

    vel -= 1
    current += vel
    step += 1

    break if current < y1
  end

  ys << [min_step..may_step, yv] if min_step
end

y_map = Hash.new { |h, k| h[k] = [] }

ys.each do |step_range, yv|
  y_map[step_range] << yv
end


combinations = []

y_map.each do |y_step_range, ys|
  x_map.each do |x_step_range, xs|
    y_step_range.each do |y|
      combinations += ys.product(xs) if x_step_range.cover?(y)
    end
  end
end

puts combinations.uniq.count

