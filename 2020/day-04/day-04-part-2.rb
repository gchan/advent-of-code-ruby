#!/usr/bin/env ruby

file_path = File.expand_path('day-04-input.txt', __dir__)
input     = File.read(file_path)

passes = input.split("\n\n")

expect = {
  byr: 1920..2002,
  iyr: 2010..2020,
  eyr: 2020..2040,
  hgt: /1([5-8]\d|9[0-3])cm|(59|6\d|7[0-6])in/,
  hcl: /#[0-9a-f]{6}/,
  ecl: /(amb|blu|brn|gry|grn|hzl|oth)/,
  pid: /\d{9}/
}.transform_keys(&:to_s)

puts passes.count { |pass|
  fields = Hash[
    pass.split(/\s/).map { |field| field.split(":") }
  ]

  expect.all? do |k, v|
    field = fields[k]

    next unless field

    if v.is_a?(Regexp)
      field.match?(/\A#{v}\z/)
    else
      v.cover?(field.to_i)
    end
  end
}
