#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

registers, commands = input.split("\n\n")

reg = registers.scan(/\d+/).map(&:to_i)
cmds = commands.scan(/\d+/).map(&:to_i)

def run(cmds, a_reg)
  reg = [a_reg, 0, 0]

  out = []

  ptr = 0

  while ptr < cmds.length
    cmd, op = cmds[ptr], cmds[ptr + 1]

    lit = op
    co = op
    if op >= 4 && op<= 6
      co = reg[op - 4]
    end

    case cmd
    when 0
      reg[0] = reg[0] / (2**co)
    when 1
      reg[1] = reg[1] ^ lit
    when 2
      reg[1] = co % 8
    when 3
      if reg[0] != 0 && lit != ptr
        ptr = lit
        next
      end
    when 4
      reg[1] = reg[1] ^ reg[2]
    when 5
      out << co % 8
    when 6
      reg[1] = reg[0] / (2**co)
    when 7
      reg[2] = reg[0] / (2**co)
    end

    ptr += 2
  end

  return out
end

# The device runs in a loop and prints an output once per loop.
# At the end of the one loop, the least significant 3 bits are discarded.
# Registers B and C are derived by the A register at the start of each
# iteration of the loop
#
# So we can build up the desired output from building up the value of A
# by shifting the value by 3 bits in each iteration (i.e. multiplying A
# by 8). The search space is 3 bits (8 values) each time so it's feasible
# to 'brute force'.

goal = cmds.clone

target = []
solutions = [0] # to initialise the search space, zero not a valid solution!

while goal.any?
  target.unshift(goal.pop)

  new_solutions = []

  solutions.each {
    solution = _1 * 8

    from = solution
    to = solution + 8

    (from..to).each { |input|
      out = run(cmds, input)
      new_solutions << input if out == target
    }
  }

  solutions = new_solutions
end

puts solutions.min
