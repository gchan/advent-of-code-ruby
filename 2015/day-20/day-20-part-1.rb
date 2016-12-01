#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
target    = File.read(file_path).to_i

houses = Hash.new(0)

1.upto(target / 10) do |elf|
  1.upto(target / 10 / elf) do |number|
    houses[number * elf] += elf * 10
  end
end

lowest_house = houses.find do |_house, presents|
  presents >= target
end

puts lowest_house
