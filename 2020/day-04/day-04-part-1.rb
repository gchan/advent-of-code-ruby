#!/usr/bin/env ruby

file_path = File.expand_path('day-04-input.txt', __dir__)
input     = File.read(file_path)

passes = input.split("\n\n")

expect = %w(byr iyr eyr hgt hcl ecl pid)

puts passes.count { |pass|
  expect.all? { |field| pass.match?(/#{field}:\S+/) }
}
