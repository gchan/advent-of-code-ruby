#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

# We don't need a fany Hash here for the given input. We could
# make do with an Array and call `DIGITS.index(match)&.+(1)`
# instead of `DIGITS[match]`
DIGITS = %w(one two three four five six seven eight nine)
  .map.with_index
  .to_a.to_h
  .transform_values { _1 + 1 }

# Postive lookahead assertion regex
input
  .split("\n")
  .sum {
    _1.scan(/(?=(#{DIGITS.keys.join("|")}|\d))/)
      .flatten
      .values_at(0, -1)
      .map { |match| DIGITS[match] || match }
      .join
      .to_i
  }
  .tap { puts _1 }
