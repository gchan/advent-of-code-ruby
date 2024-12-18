#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

$cache = {}

def path?(input, simulate, size)
  return $cache[simulate] if $cache.has_key?(simulate)

  grid = ("." * size * size).chars.each_slice(size).to_a

  input.split
    .map { _1.split(?,).map(&:to_i) }
    .slice(0, simulate)
    .each { |x, y| grid[y][x] = ?# }

  start = [0, 0]

  queue = []
  queue << [start, 0]

  visited = Set.new

  while queue.any?
    loc, steps = queue.pop
    x, y = loc

    candidates = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]

    candidates
      .reject { _1 < 0 || _2 < 0 || _1 >= size || _2 >= size }
      .reject { grid[_2][_1] == ?# }
      .reject { visited.include?([_1, _2]) }
      .each {
        if _1 == size - 1 && _2 == size - 1
          $cache[simulate] = true
          return true
        end

        visited.add([_1, _2])
        queue.unshift [[_1, _2], steps + 1]
      }
  end

  $cache[simulate] = false
  false
end

size = 71
simulate = 1024

bytes = input.split.map { _1.split(?,).map(&:to_i) }

byte = (simulate..bytes.size-1).bsearch {
  left = path?(input, _1, size)
  right = path?(input, _1 + 1, size)

  if left && right
    1
  elsif left && !right
    0
  else # !left
    -1
  end
}

puts bytes[byte].join(?,)


## Handrolled binary search

low = simulate
high = bytes.size - 1

while low <= high
  mid = low + (high - low) / 2

  # possible outcomes:
  # [true, true], [true, false], [false, false]
  left = path?(input, mid, size)
  right = path?(input, mid + 1, size)

  break if left && !right

  if left
    low = mid + 1
  else
    high = mid - 1
  end
end

puts bytes[mid].join(?,)
