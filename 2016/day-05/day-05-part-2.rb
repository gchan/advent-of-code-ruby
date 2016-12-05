#!/usr/bin/env ruby

require 'digest'

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

i = 0

pw = "........"

loop do
  digest = Digest::MD5.hexdigest(input + i.to_s)

  if digest.start_with?("00000") && digest[5].match(/[0-7]/)
    pos = digest[5].to_i

    if pw[pos] == '.'
      pw[pos] = digest[6]
      puts pw
    end

    break unless pw.match(/\./)
  end

  i += 1
end

puts pw
