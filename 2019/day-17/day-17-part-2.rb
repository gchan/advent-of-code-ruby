#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

def run(codes, inputs = [])
  relative_base = 0
  i = 0
  out = []

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
      inp = inputs.shift.ord
      codes[refs[0]] = inp
    when 4
      out << codes[refs[0]]
      if (0..127).cover?(out.last)
        print out.last.chr
      else
        print out.last
      end
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
  end

  out
end

codes = input.split(",").map(&:to_i)

out = run(codes.clone)
map = out.map(&:chr).join

grid = map.split("\n").map { |row| row.split('') }
rows = grid.size
cols = grid[0].size

x, y = 0, 0

grid.each_with_index do |row, y1|
  row.each_with_index do |cell, x1|
    x, y = x1, y1 if cell == ?^
  end
end

# N, E, S, W
dir = [[0, -1], [1, 0], [0, 1], [-1, 0]]

facing = dir[0]
path = []

while true
  facing_idx = dir.index(facing)
  left = dir[(facing_idx - 1) % 4]
  right = dir[(facing_idx + 1) % 4]

  x1 = x + left[0]
  y1 = y + left[1]

  if (0..grid[0].size-1).cover?(x1) && (0..grid.size-1).cover?(y1) &&
      grid[y1][x1] == ?#
    facing = left
    path << ?L
  elsif grid[y + right[1]][x + right[0]] == ?#
    facing = right
    path << ?R
  else
    break
  end

  dist = 0
  while grid[y + facing[1]][x + facing[0]] == ?#
    y += facing[1]
    x += facing[0]
    dist += 1
  end

  path << dist
end

path = path.join(?,)
puts path

funcs = {}
letters = ["A", "B", "C"]

while path =~ /L|R/
  20.times.reverse_each do |len|
    from = path.index(/L|R/)
    to = from + len
    func = path[from..to]
    next if func[-1] == ?, || func =~ /A|B/

    if path[to..-1].include?(func)
      letter = letters[funcs.count]
      path.gsub!(func, letter)
      funcs[letter] = func
      break
    end
  end
end

puts path
puts funcs
puts

inputs = [path].concat(funcs.values)
inputs = inputs.join("\n") + "\nY\n"

puts inputs.inspect

puts "Press enter to run code"
gets

codes[0] = 2
run(codes.clone, inputs.chars)
