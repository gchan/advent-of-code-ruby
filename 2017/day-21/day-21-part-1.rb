#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input = File.read(file_path)

pattern = [
  %w(. # .),
  %w(. . #),
  %w(# # #),
]

trans = {}

input.split("\n").each do |line|
  from, to = line.split(" => ").map do |r|
    r.split("/").map(&:chars)
  end

  trans[from] = to
end

5.times do |i|
  size = pattern.size % 2 == 0 ? 2 : 3
  squares = pattern.size / size
  new_size = squares * (size + 1)

  new_pattern = Array.new(new_size) { Array.new(new_size) }

  squares.times.to_a.product(squares.times.to_a) do |x, y|
    square = size.times.map do |i|
      pattern[y * size + i][(x * size)...((x + 1) * size)]
    end

    rotated = [square]
    rotated << rotated[-1].transpose.reverse
    rotated << rotated[-1].transpose.reverse
    rotated << rotated[-1].transpose.reverse
    rotated.concat rotated.map{ |sq| sq.map(&:reverse) }

    _, to = trans.find do |from, _|
      rotated.any? { |square| square == from }
    end

    to.each.with_index do |row, y2|
      row.each.with_index do |cell, x2|
        new_pattern[y * (size + 1) + y2][x * (size + 1) + x2] = cell
      end
    end
  end

  pattern = new_pattern
end

puts pattern.flatten.count{ |a| a == '#' }
