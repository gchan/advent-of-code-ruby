#!/usr/bin/env ruby

require 'json'

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

def compare(l1, l2)
  return 0 if l1 == l2

  l1.each_with_index do |i1, idx|
    i2 = l2[idx]

    return 1 if i2.nil?

    next if i1 == i2

    if i1.is_a?(Integer) && i2.is_a?(Integer)
      return i1 <=> i2
    else
      i1 = [i1] if i1.is_a?(Integer)
      i2 = [i2] if i2.is_a?(Integer)

      next if i1 == i2
      return compare(i1, i2)
    end
  end

  -1
end

lists = input.scan(/\[.*/).map { |l| JSON.parse(l) }

d1 = [[2]]
d2 = [[6]]

lists << d1
lists << d2

lists.sort! { |l1, l2| compare(l1, l2) }

puts (lists.index(d1) + 1 ) * (lists.index(d2) + 1)
