#!/usr/bin/env ruby

# Includes solution for part 2

class Marble
  attr_accessor :left, :right, :value

  def initialize(value, left = nil, right = nil)
    @left = left || self
    @right = right || self
    @value = value
  end

  def remove
    left = self.left
    right = self.right

    left.right = right
    right.left = left
  end

  def insert_right(value)
    right = self.right

    marble = Marble.new(value, self, right)

    self.right = marble
    right.left = marble
  end
end

def scores(players, max)
  scores = Array.new(players, 0)
  value = 0

  current = Marble.new(value)

  max.times do |value|
    value += 1
    player = value % players

    if value % 23 == 0
      7.times { current = current.left }

      scores[player] += current.value
      scores[player] += value

      current.remove
      current = current.right
    else
      current.right.insert_right(value)

      current = current.right.right
    end
  end

  scores
end

# puts scores(9, 25).max
# puts scores(10, 1618).max
# puts scores(13, 7999).max
# puts scores(17, 1104).max
# puts scores(21, 6111).max
# puts scores(30, 5807).max
puts scores(455, 71223).max
