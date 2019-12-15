#!/usr/bin/env ruby

require 'io/console'

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

codes = Hash.new(0)

input.split(",").each_with_index do |code, i|
  codes[i] = code.to_i
end

x = y = 0
step = 1

map = { [x,y] => false }
visited = {}

reverse_move = {
  1 => 2,
  2 => 1,
  3 => 4,
  4 => 3
}

# Starting movement commands inputs - depth-first
stack = reverse_move.keys

found = nil
manual_mode = false

relative_base = 0
i = 0
out = nil
inp = nil

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
    inp = stack.pop

    if manual_mode
      # wasd
      char = STDIN.getch
      case char
      when 'w'
        inp = 1
      when 'a'
        inp = 3
      when 's'
        inp = 2
      when 'd'
        inp = 4
      else
        exit
      end
    end

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
    if out == 0
      y1 = y
      x1 = x

      case inp
      when 1
        y1 = y - 1
      when 2
        y1 = y + 1
      when 3
        x1 = x - 1
      when 4
        x1 = x + 1
      end

      map[[x1, y1]] = true
    else
      case inp
      when 1
        y -= 1
      when 2
        y += 1
      when 3
        x -= 1
      when 4
        x += 1
      end

      found = [x, y] if out == 2

      # Depth-first search
      if !visited[[x,y]]
        # Backtrack
        reverse_direction = reverse_move[inp]
        stack << reverse_direction

        movements = reverse_move.keys
        movements.delete reverse_direction

        stack.concat(movements)

        visited[[x, y]] = step
        step += 1
        map[[x, y]] = false
      else
        step -= 1
      end
    end

    if manual_mode || stack.empty? || visited.length % 20 == 0
      puts "\e[H\e[2J"

      Range.new(*map.keys.map(&:last).minmax).each do |y2|
        Range.new(*map.keys.map(&:first).minmax).each do |x2|
          if map[[x2, y2]]
            print "#"
          elsif x2 == x && y2 == y
            print "D"
          elsif x2 == 0 && y2 == 0
            print "S"
          elsif found && found[0] == x2 && found[1] == y2
            print "O"
          elsif visited[[x2, y2]]
            print "."
          else
            print " "
          end
        end
        print "\n"
      end
    end

    out = nil
  end
end

puts visited[found]
