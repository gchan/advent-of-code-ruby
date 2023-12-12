#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

def count_arrangements(pattern, groups, cache = {})
  result = cache[[pattern, groups]]
  return result if result

  if groups.empty?
    if !pattern&.match?(/#/)
      count = 1
    else
      count = 0
    end

    cache[[pattern, groups]] = count
    return count
  end

  expected = groups[0]
  remainder = groups[1..]

  # Minimum width required to satistify the remaining groups
  reserved = remainder.sum + remainder.length

  # Amount of width (less expected split) available to test
  space = pattern.size - reserved - (expected - 1)

  candidates = space.times.map { "." * _1 + "#" * expected + "." }

  candidates
    .select {
      _1.chars.zip(pattern.chars).all? do |c, p|
        c == p || p == "?" || p.nil?
      end
    }
    .sum {
      count_arrangements(pattern[_1.length..], remainder, cache)
    }
    .tap { cache[[pattern, groups]] = _1 }
end

input.each_line
  .sum {
    pattern, groups = _1.split
    groups = groups.split(",").map(&:to_i)

    count_arrangements(pattern, groups)
  }
  .tap { puts _1 }
