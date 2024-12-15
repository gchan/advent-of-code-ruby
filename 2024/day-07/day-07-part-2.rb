#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

input.split(?\n)
  .map(&:split)
  .map { _1.map(&:to_i) }
  .select { |target, *nums|
    operators = nums.size - 1

    (0..(3**operators - 1)).find {
      ops = _1.to_s(3).rjust(operators, ?0).tr("012", "*+|").chars

      total = nums.first

      nums[1..].each.with_index { |num, idx|
        case ops[idx]
        when ?*
          total *= num
        when ?+
          total += num
        when ?|
          total = (total.to_s + num.to_s).to_i
        end
      }

      total == target
    }
  }
  .map { _1.first }
  .sum
  .tap { puts _1 }
