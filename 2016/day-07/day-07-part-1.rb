#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

def abba?(text)
  text.chars.each_cons(4) do |chars|
    str = chars.join
    next if str[0] == str[1]
    if str[0..1] == str[2..3].chars.reverse.join
      return true
    end
  end

  false
end

tls = lines.select do |line|
  strings = line.split(/\[|\]/)

  sequences, hypernets = strings.partition.with_index do |str, idx|
    idx.even?
  end

  sequences.any?{ |seq| abba?(seq) } &&
    !hypernets.any?{ |seq| abba?(seq) }
end

puts tls.count
