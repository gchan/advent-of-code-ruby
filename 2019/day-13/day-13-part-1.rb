#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path).strip

codes = Hash.new(0)

input.split(",").each_with_index do |code, i|
  codes[i] = code.to_i
end

inp = 0
i = 0
relative_base = 0

x = nil
y = nil
out = nil

map = []
26.times { map <<  [] }

loop do
  opcode = codes[i] % 100

  modes = (codes[i] / 100).digits
  3.times { modes << 0 }

  refs = modes.map.with_index do |m, idx|
    address = i + idx + 1

    if m == 1
      address
    elsif m == 2
      relative_base + codes[address]
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
    codes[refs[0]] = inp
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
  when 9
    relative_base += codes[refs[0]]
  when 99
    break
  end

  codes[refs[2]] = codes[refs[0]].send(op, codes[refs[1]]) if op

  if [1, 2, 7, 8].include?(opcode)
    i += 4
  elsif [5, 6].include?(opcode)
    i += 3
  else
    i += 2
  end

  if out
    if x.nil?
      x = out
    elsif y.nil?
      y = out
    else
      case out
      when 0
        out = " "
      when 1
        out = "#"
      when 2
        out = "x"
      when 3
        out = "="
      when 4
        out = "O"
      end

      map[y][x] = out
      x = nil
      y = nil
    end

    out = nil
  end
end

puts map.map(&:join).join("\n")

puts map.flatten.count { |cell| cell == "x" }
