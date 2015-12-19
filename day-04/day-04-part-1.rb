#!/usr/bin/env ruby

require 'digest'

file_path = File.expand_path("../day-4-input.txt", __FILE__)
input     = File.read(file_path)

number = 0

while true
  digest = Digest::MD5.hexdigest("#{input}#{number}")
  break if digest =~ /\A00000/

  number += 1
end

puts number