#!/usr/bin/env ruby

require 'digest'

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

i = 0

pw = []

while pw.length < 8 do
  digest = Digest::MD5.hexdigest(input + i.to_s)

  pw << digest[5] if digest.start_with?("00000")

  i += 1
end

puts pw.join
