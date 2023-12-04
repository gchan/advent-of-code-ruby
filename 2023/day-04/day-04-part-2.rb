#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

input
  .each_line
  .with_object(Hash.new(0)) { |line, counts|
    id, winners, numbers = line.split(/[:|]/)

    id = id.scan(/\d+/).first.to_i
    winners = winners.scan(/\d+/)
    numbers = numbers.scan(/\d+/)

    matches = (winners & numbers).count

    counts[id] += 1

    matches.times do |i|
      card_id = id + i + 1
      counts[card_id] += counts[id]
    end
  }
  .values
  .sum
  .tap { puts _1 }
