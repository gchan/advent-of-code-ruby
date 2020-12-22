#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

one = input.match(/1:\s((\d+\s)+)/).captures.first.split.map(&:to_i)
two = input.match(/2:\s((\d+\s)+)/).captures.first.split.map(&:to_i)

def game(one, two, decks)
  while one.any? && two.any?
    return [true, one] if decks.include? [one, two]
    decks.add [one, two]

    o = one.shift
    t = two.shift

    if o <= one.size && t <= two.size
      one_wins , _, _ = game(one[0, o], two[0, t], decks)
    else
      one_wins = o > t
    end

    if one_wins
      one << o
      one << t
    else
      two << t
      two << o
    end
  end

  winner = one.any? ? one : two
  [one.any?, winner]
end

decks = Set.new

_, winner = game(one, two, decks)

puts winner.reverse.map.with_index { |num, idx| num * (idx + 1) }.sum

