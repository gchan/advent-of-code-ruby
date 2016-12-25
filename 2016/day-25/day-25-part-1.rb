#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input     = File.read(file_path)

def argToVal(arg, reg)
  if arg =~ /\d/
    arg.to_i
  else
    reg[arg]
  end
end

def solve(val, input)
  reg = { "a" => val }
  out = []
  i = 0

  instructions = input.split("\n")

  while i < instructions.length
    cmd, arg1, arg2 = instructions[i].split(" ")

    arg1Val = argToVal(arg1, reg)
    arg2Val = argToVal(arg2, reg)

    case cmd
    when 'out'
      return false if arg1Val == out.last
      return true if out.size > 50

      out << arg1Val
    when 'cpy'
      reg[arg2] = arg1Val
    when 'jnz'
      i += arg2Val - 1 if arg1Val != 0
    when 'inc'
      reg[arg1] += 1
    when 'dec'
      reg[arg1] -= 1
    when 'tgl'
      idx = i + reg[arg1]

      if instructions[idx]
        cmd, arg1, arg2 = instructions[idx].split(" ")

        if arg2
          replacement = cmd == "jnz" ? "cpy" : "jnz"
        else
          replacement = cmd == "inc" ? "dec" : "inc"
        end

        instructions[idx][0..2] = replacement
      end
    end

    i += 1
  end
end

(1..1_000).each do |i|
  if solve(i, input)
    puts i
    exit
  end
end
