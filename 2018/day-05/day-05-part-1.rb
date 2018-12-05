#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

loop do
  prev_length = input.length

  input.gsub!(/([A-z])\1+/i) do |match|
    chr = match[0]
    pattern = chr.downcase + chr.upcase

    match
      .gsub(pattern, "")
      .gsub(pattern.reverse, "")
  end

  break if input.length == prev_length
end

puts input.length