#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

puts input.split("\n")
  .map(&:split)
  .map { _1.map(&:to_i) }
  .map {
    _1
      .each_cons(2).to_a
      .map { |pair| pair.inject(:-) }
  }
  .select { _1.all?(&:positive?) || _1.all?(&:negative?) }
  .select { _1.map(&:abs).all? { |diff| diff <= 3 } }
  .count
