#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

def aba(text)
  result = []

  text.chars.each_cons(3) do |chars|
    str = chars.join

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
  strings = line.split(/\[|\]/)

  sequences, hypernets = strings.partition.with_index do |str, idx|
    idx.even?
  end

  abas = sequences.flat_map { |str| aba(str) }
  babs = hypernets.flat_map { |str| bab(str) }

  (abas & babs).any?
}

puts ssl.count
