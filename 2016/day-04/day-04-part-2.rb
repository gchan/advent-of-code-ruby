#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

input.split("\n").map do |room|
  name = room.match(/[a-z-]*/)[0]
  id   = room.match(/\d{3}/)[0].to_i

  cipher = ('a'..'z').to_a.rotate(id % 26)

  decrypted_name = name.tr(('a'..'z').to_a.join, cipher.join)

  puts "#{decrypted_name} #{id}" if decrypted_name.include?("north")
end
