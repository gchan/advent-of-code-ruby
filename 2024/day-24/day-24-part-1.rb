#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

wires, gates = input.split("\n\n")

wires = wires
  .split(?\n)
  .map { _1.split(": ") }
  .map { [_1, _2.to_i ] }
  .to_h

gates = gates.split(?\n)
  .map { _1.gsub("->", "").split }

outputs = gates.map(&:last)

outputs.each { wires[_1] = nil }

deps = Hash.new { |h, k| h[k] = Set.new }

gates.each do
  w1, _rule, w2, _out = _1

  deps[w1].add(_1)
  deps[w2].add(_1)
end

queue = wires
  .select { _2 }
  .map(&:first)

while queue.any?
  wire = queue.shift

  deps[wire].each { |gate|
    w1, rule, w2, out = gate

    next if wires[out]
    next if wires[w1].nil?
    next if wires[w2].nil?

    output =
      case rule
      when "XOR"
        wires[w1] ^ wires[w2]
      when "AND"
        wires[w1] & wires[w2]
      when "OR"
        wires[w1] | wires[w2]
      end

    wires[out] = output

    queue << out
  }
end

p wires.keys.sort
  .select { _1.start_with?(?z) }
  .map { wires[_1] }.join.reverse.to_i(2)
