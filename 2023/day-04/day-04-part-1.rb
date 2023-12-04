#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

input.each_line.sum {
  _, winners, numbers = _1.split(/[:|]/)

  winners = winners.scan(/\d+/)
  numbers = numbers.scan(/\d+/)

  matches = (winners & numbers).count

  if matches > 0
    2**(matches - 1)
  else
    0
  end
}
.tap { puts _1 }
