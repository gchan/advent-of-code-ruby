#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

banks = input.split("\n").map(&:chars).map { _1.map(&:to_i) }

banks.sum { |bank|
  digits = []
  target_digits = 12
  idx = 0

  while digits.size < target_digits
    digit, rel_idx = bank[idx..(-target_digits + digits.size)]
      .each.with_index
      .max_by { |value, _idx| value }

    idx += rel_idx + 1

    digits << digit
  end

  digits.join.to_i
}.tap { puts _1 }
