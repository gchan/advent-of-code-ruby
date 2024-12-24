#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

wires, raw_gates = input.split("\n\n")

wires = wires
  .split(?\n)
  .map { _1.split(": ") }
  .map { [_1, _2.to_i ] }
  .to_h

bin_length = wires.size / 2

gates = raw_gates.split(?\n)
  .map { _1.gsub("->", "").split }

outputs = gates.map(&:last)

outputs.each { wires[_1] = nil }

deps = Hash.new { |h, k| h[k] = Set.new }

gates.each do
  w1, _rule, w2, _out = _1

  deps[w1].add(_1)
  deps[w2].add(_1)
end

def compute(x, y, deps, bin_length)
  wires = {}

  x.to_s(2).rjust(bin_length, ?0).chars.reverse.each.with_index {
    wires["x#{_2.to_s.rjust(2, ?0)}"] = _1.to_i
  }

  y.to_s(2).rjust(bin_length, ?0).chars.reverse.each.with_index {
    wires["y#{_2.to_s.rjust(2, ?0)}"] = _1.to_i
  }

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

  wires.keys.sort
    .select { _1.start_with?(?z) }
    .map { wires[_1] }
end

#x = wires.select { _1.start_with?(?x) }.sort
#  .map(&:last).join.reverse.to_i(2)
#y = wires.select { _1.start_with?(?y) }.sort
#  .map(&:last).join.reverse.to_i(2)

def bit_errors(deps, bin_length)
  errors = []
  bin_length.times do |bin|
    n = 2 ** bin

    [[0, n], [n, 0], [n, n]].each do |x, y|
      z = x + y

      z_bin = z.to_s(2).rjust(bin_length + 1, ?0).chars
        .map(&:to_i).reverse.join

      output = compute(x, y, deps, bin_length)

      if output.join != z_bin
        errors << bin
      end
    end
  end

  errors.uniq.sort
end

errors = bit_errors(deps, bin_length)
puts "#{errors.count} bit errors"
p errors
puts

# The wires and gates represent a Ripple-carry adder which is composed
# many full adders, one for each bit. The first bit is a half adder as
# it has no input carry bit.
#
# https://en.wikipedia.org/wiki/Adder_(electronics)#Ripple-carry_adder
# https://en.wikipedia.org/wiki/Adder_(electronics)#Full_adder
#
# Truth table from Wikipedia:
#
# Inputs   Outputs
# A B Cin  Cout S
# 0 0 0    0    0
# 0 0 1    0    1
# 0 1 0    0    1
# 0 1 1    1    0
# 1 0 0    0    1
# 1 0 1    1    0
# 1 1 0    1    0
# 1 1 1    1    1
#
# Which can be expressed by the logic gates:
#
# S = A XOR B XOR Cin
# Cout = (A AND B) OR ( (A XOR B) AND Cin )
#
# Cin is the carry bit from the previous bit as Cout.
#
# S is the 'z' wires in our case so we expect an XOR operator
# where 'z' is the output.
# Observation: Z shouldn't be part of any OR and AND operators.
#
# A and B is 'x' and 'y' in our case, so we should expect
# to find 'x XOR y -> M' where M is then featured in 'M XOR Cin'
# and 'M AND Cin'.
# Observation: M shouldn't be in an OR operators, where x XOR y -> M
#
# 'x AND y -> N' contributes to the carry bit, Cout. It should be always
# fed into an OR operator.
# Observation: N must be invovlved in an OR operator, where x AND y -> N
#
# Observation: Cout, the output carry bit is the result of an OR operator
# Observation: Cin, the incoming carry bit operator is not
# invovled in any OR operators
#

# Gates where Z is the output and the operator isn't XOR
# All these need swaping
z_swaps = gates.select { |a, op, b, out| out.start_with?(?z) && op != "XOR" }

# The last z bit is a carry bit so it can be the output of an OR operator
z_swaps.reject! { _4 == "z#{bin_length}" }

# Gates with XOR operators but no Z output and do not involve X and Y as
# inputs and also doesn't involve M where x XOR y -> M
xor_swaps = gates.select { |a, op, b, out|
  !out.start_with?(/z/) &&
    op == "XOR" &&
    !a.start_with?(/[xy]/)
}

# Wires in the first set need to swap with items in the second
p z_swaps
p xor_swaps
puts


# x XOR y -> M and M must be invovled in as inputs for XOR and AND
# gates (i.e. can't be involved with an OR operator)
m = gates.select { |a, op, b, out| op == "XOR" && a.start_with?(/[xy]/) }
  .map { _4 }

incorrect_m = gates
  .select { |a, op, b, out|
    op == "OR" && (m.include?(a) || m.include?(b))
  }
  .flat_map { [_1, _3] }
  .select { m.include?(_1) }

m_swaps = gates.select { |a, op, b, out|
  op == "XOR" && incorrect_m.include?(out)
}

# 'x AND y -> N' and N must be involved in an OR operator
n = gates.select { |a, op, b, out| op == "AND" && a.start_with?(/[xy]/) }
  .map { _4 }

incorrect_n = gates
  .select {
    |a, op, b, out| op != "OR" && (n.include?(a) || n.include?(b))
  }
  .flat_map { [_1, _3] }
  .select { n.include?(_1) }
  .uniq

n_swaps = gates.select { |a, op, b, out|
  op == "AND" && incorrect_n.include?(out)
}

# x00 AND y00 -> N do not invovle an OR operator as there is no input
# carry bit. So x00 AND y00 simply becomes the output carry bit
n_swaps.reject! { _1.first.end_with?("00") }

# Wires in the first set need to swap with items in the second
p m_swaps
p n_swaps
puts

z_wires = z_swaps.map(&:last)
xor_wires = xor_swaps.map(&:last)
m_wires = m_swaps.map(&:last)
n_wires = n_swaps.map(&:last)

# Superfluous verification step
z_perms = z_wires.permutation(z_wires.size).to_a
z_swap_pairs = z_perms.map { _1.zip(xor_wires) }

m_perms = m_wires.permutation(m_wires.size).to_a
nm_swap_pairs = m_perms.map { _1.zip(n_wires) }

swap_pairs = z_swap_pairs.product(nm_swap_pairs)
  .map { _1.inject(&:concat) }

swap_pairs.each do |attempt|
  attempt.concat(attempt.map(&:reverse))

  deps_copy = Hash.new { |h, k| h[k] = Set.new }

  regex = Regexp.new(
    attempt.map(&:first).map { "(?<=-> )#{_1}" }.join(?|)
  )

  gates = raw_gates
    .gsub(regex, attempt.to_h)
    .split(?\n)
    .map { _1.gsub("->", "").split }

  gates.each do
    w1, _rule, w2, _out = _1

    deps_copy[w1].add(_1)
    deps_copy[w2].add(_1)
  end

  errors = bit_errors(deps_copy, bin_length)

  if errors.count == 0
    puts "swap pairs"
    p attempt
    break
  end
end

wire_swap = z_wires + xor_wires + m_wires + n_wires

puts
puts wire_swap.sort.join(?,)
