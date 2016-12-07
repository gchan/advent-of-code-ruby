#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

def aba(text)
  result = []

  text.length.times.flat_map do |i|
    str = text[i..(i+2)]

    result << str if str[0] == str[2]
  end

  result
end

def bab(text)
  aba(text).map do |aba|
    aba[1] + aba[0] + aba[1]
  end
end

ssl = lines.select { |line|
  sequences = line.scan(/(\w+)\[/).flatten +
     line.scan(/\](\w+)/).flatten

  hypernets = line.scan(/\[(\w+)\]/).flatten

  abas = sequences.flat_map { |str| aba(str) }
  babs = hypernets.flat_map { |str| bab(str) }

  (abas & babs).any?
}

puts ssl.count
