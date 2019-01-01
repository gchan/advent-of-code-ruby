#!/usr/bin/env ruby

# Includes alternative solution for part 1

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input = File.read(file_path)

path = input[1..-2]

def visit(path, x0 = 0, y0 = 0, visited = {}, start = 1)
  x = x0
  y = y0

  doors = start
  visited[[x, y]] = doors - 1

  idx = 0

  while idx < path.length
    case path[idx]
    when ?(
      length = branch_length(path[idx..-1])

      branch = path[idx + 1, length - 1]

      visit(branch, x, y, visited, doors)

      idx += length
    when ?|
      x, y, doors = x0, y0, start
    else
      case path[idx]
      when ?N
        y -= 1
      when ?W
        x -= 1
      when ?E
        x += 1
      when ?S
        y += 1
      end

      visited[[x, y]] = [visited[[x, y]], doors].compact.min

      doors += 1
    end

    idx += 1
  end

  visited
end

def branch_length(path)
  depth = 1
  idx = 0

  while depth > 0
    idx += 1

    depth -= 1 if path[idx] == ?)
    depth += 1 if path[idx] == ?(
  end

  idx
end

visited_rooms = visit(path)

puts visited_rooms.values.count { |doors| doors >= 1000 } # Part 2
puts visited_rooms.values.max # Part 1
