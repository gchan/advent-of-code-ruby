#!/usr/bin/env ruby

require 'json'

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

json = JSON.parse(input)

def find_numbers(input)
  case input
  when Array
    input.flat_map { |value| find_numbers(value) }.compact
  when Hash
    if input.values.include? "red"
      [nil]
    else
      find_numbers(input.values).compact
    end
  when String
    [nil]
  when Fixnum
    [input]
  end
end

puts find_numbers(json).inject(:+)
