#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

def run(codes, inp, phase)
  i = 0
  out = nil

  loop do
    opcode = codes[i] % 100

    modes = (codes[i] / 100).digits
    3.times { modes << 0 }

    refs = modes.map.with_index do |m, idx|
      address = i + idx + 1

      if m == 1
        address
      else
        codes[address]
      end
    end

    case opcode
    when 1
      op = :+
    when 2
      op = :*
    when 3
      codes[refs[0]] = phase || inp
      phase = nil
    when 4
      out = codes[refs[0]]
    when 5
      if codes[refs[0]] != 0
        i = codes[refs[1]]
        next
      end
    when 6
      if codes[refs[0]] == 0
        i = codes[refs[1]]
        next
      end
    when 7
      if codes[refs[0]] < codes[refs[1]]
        codes[refs[2]] = 1
      else
        codes[refs[2]] = 0
      end
    when 8
      if codes[refs[0]] == codes[refs[1]]
        codes[refs[2]] = 1
      else
        codes[refs[2]] = 0
      end
    when 99
      return out
    end

    codes[refs[2]] = codes[refs[0]].send(op, codes[refs[1]]) if op

    if [1, 2, 7, 8].include?(opcode)
      i += 4
    elsif [5, 6].include?(opcode)
      i += 3
    else
      i += 2
    end
  end
end

codes = input.split(",").map(&:to_i)

best = 0

(0..4).to_a.permutation.each do |phases|
  inp = 0

  phases.each do |phase|
    inp = run(codes.clone, inp, phase)
  end

  best = [inp, best].max
end

puts best
