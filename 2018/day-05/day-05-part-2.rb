#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

shortest = nil

('a'..'z').each do |char|
  test = input.gsub(/#{char}/i, "")

  loop do
    prev_length = test.length

    test.gsub!(/([A-z])\1+/i) do |match|
      chr = match[0]
      pattern = chr.downcase + chr.upcase

      match
        .gsub(pattern, "")
        .gsub(pattern.reverse, "")
    end

    break if test.length == prev_length
  end


  if shortest.nil? || test.length < shortest
    shortest = test.length
    puts char
    puts shortest
  end
end
