#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)
ranges = input.split(?,)

ranges.sum { |range|
  min, max = range.split(?-).map(&:to_i)

  (min..max)
    .select { |n|
      str = n.to_s

      length = str.length

      (1...length)
        .select { length % _1 == 0 }
        .any? { |i|
          str.match?(/\A(#{str[0...i]})+\z/)
        }
    }
    .sum
}.tap { puts _1}
