#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

numbers = input.split("\n")

o2 = numbers.map(&:chars)

o2[0].size.times do |idx|
  max_bit = "1"

  count = o2.count { |o| o[idx] == "0" }

  if count > o2.size / 2.0
    max_bit = "0"
  end

  o2.select! { |o| o[idx] == max_bit }

  break if o2.count == 1
end

o2_rating = o2.join.to_i(2)


co2 = numbers.map(&:chars)

co2[0].size.times do |idx|
  max_bit = "0"

  count = co2.count { |co| co[idx] == "1" }

  if count < co2.size / 2.0
    max_bit = "1"
  end

  co2.select! { |co| co[idx] == max_bit }

  break if co2.count == 1
end

co2_rating = co2.join.to_i(2)

puts co2_rating * o2_rating
