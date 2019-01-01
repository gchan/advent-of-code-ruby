#!/usr/bin/env ruby

# Cheeky solution without building a map
# See part 2 for alternative solution for part 1

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input = File.read(file_path)

path = input[1..-2]

def longest(path)
  path_lengths = [0]

  idx = 0

  while idx < path.length
    case path[idx]
    when ?(
      length = branch_length(path[idx..-1])

      branch = path[idx + 1, length - 1]

      path_lengths[-1] += longest(branch)

      idx += length
    when ?|
      path_lengths << 0
    else
      path_lengths[-1] += 1
    end

    idx += 1
  end

  if path_lengths.any?(&:zero?)
    0
  else
    path_lengths.max
  end
end

def branch_length(branch)
  depth = 1
  idx = 0

  while depth > 0
    idx += 1

    depth -= 1 if branch[idx] == ?)
    depth += 1 if branch[idx] == ?(
  end

  idx
end

puts longest(path)
