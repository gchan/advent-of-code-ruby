#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

input.split(?\n)
  .map(&:split)
  .map { _1.map(&:to_i) }
  .select { |target, *nums|
    operators = nums.size - 1

    (0..(2**operators - 1)).find {
      ops = _1.to_s(2).rjust(operators, ?0).tr("01", "*+").chars

      total = nums.first

      nums[1..].each.with_index { |num, idx|
        total = total.send(ops[idx], num)
      }

      total == target
    }
  }
  .map { _1.first }
  .sum
  .tap { puts _1 }
