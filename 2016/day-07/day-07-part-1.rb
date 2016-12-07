#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

def abba?(text)
  (text.length - 1).times do |i|
    str = text[i..(i+3)]
    next if str[0] == str[1]
    if str[0..1] == str[2..3].chars.reverse.join
      return true
    end
  end

  false
end

tls = lines.select do |line|
  sequences = line.scan(/(\w+)\[/).flatten +
     line.scan(/\](\w+)/).flatten

  hypernets = line.scan(/\[(\w+)\]/).flatten

  sequences.any?{ |seq| abba?(seq) } &&
    !hypernets.any?{ |seq| abba?(seq) }
end

puts tls.count
