#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

deck_size = 10007

deck = (0..deck_size-1).to_a

input.each_line do |line|
  if line.match(/deal into new stack/)
    deck.reverse!
  elsif line.match(/cut (-*\d+)/)
    cut = $1.to_i
    deck.rotate!(cut)
  elsif line.match(/deal with increment (\d+)/)
    incr = $1.to_i

    deck_copy = Array.new(deck_size)

    deck_size.times do |card|
      deck_copy[(card * incr) % deck_size] = deck[card]
    end

    deck = deck_copy
  end
end

puts deck.index(2019)
