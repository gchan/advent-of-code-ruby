#!/usr/bin/env ruby

require 'digest'
require 'set'

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

triples = []
keys = Set.new

number = 0

while keys.length < 64
  digest = Digest::MD5.hexdigest("#{input}#{number}")

  five_match = digest =~ /(.)\1\1\1\1/
  if five_match
    triples.each do |triple, pattern|
      if digest[five_match] == pattern[0] && triple + 1000 >= number
        keys.add(triple)
        puts triple if keys.count == 64
        puts [keys.count, triple].join(", ")
      end
    end
  end

  triple_match = digest =~ /(.)\1\1/
  triples << [number, digest[triple_match]] if triple_match

  number += 1
end
