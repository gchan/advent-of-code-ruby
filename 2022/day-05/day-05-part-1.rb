#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

stacks, instructions = input.split("\n\n")

stacks = stacks.split("\n")
num_stacks = stacks.pop.split.last.to_i

rows = stacks.map { |row|
  row = row.chars.each_slice(4).map { |col| col.join.scan(/\w/).first }

  (num_stacks - row.length).times { row << nil }

  row
}

stacks = rows.transpose.map(&:compact)

instructions.each_line do |instruction|
  count, from, to = instruction.scan(/(\d+).*(\d+).*(\d+)/)[0].map(&:to_i)

  stacks[to -1].unshift(
    *stacks[from - 1].shift(count).reverse
  )
end

puts stacks.map(&:first).join
