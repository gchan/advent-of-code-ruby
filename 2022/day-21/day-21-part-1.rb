#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

monkeys = input.split(?\n).map {
  out, ins = _1.split(": ")
  ins = ins.to_i if ins.match?(/\d+/)

  [out, ins]
}

solved, unsolved = monkeys
  .partition { _2.is_a?(Numeric) }
  .map(&:to_h)

while unsolved.any?
  unsolved.each do |out, expression|
    a, op, b = expression.split
    next unless solved[a] && solved[b]

    solved[out] = solved[a].send(op, solved[b])
    unsolved.delete(out)
  end
end

puts solved["root"]
