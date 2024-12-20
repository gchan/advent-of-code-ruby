#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split.map(&:chars)

height = grid.length
width = grid[0].length

visited = Set.new

groups = Hash.new { |h, k| h[k] = [] }

while visited.size < width * height
  i = (width * height).times.find { |i|
    x = i % width
    y = i / width

    !visited.include?([x, y])
  }

  x = i % width
  y = i / width

  visited.add([x, y])

  plant = grid[y][x]
  groups[plant] << Set.new([[x, y]])

  queue = []
  queue << [x, y]

  while queue.any?
    x, y = queue.shift

    plant = grid[y][x]

    [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
      .reject { _1 < 0 || _2 < 0 || _1 >= width || _2 >= height }
      .select { plant == grid[_2][_1] }
      .each {
        next if visited.include?([_1, _2])

        queue << [_1, _2]
        visited.add([_1, _2])
        groups[plant][-1].add([_1, _2])
      }
  end
end

groups.values.flatten
  .map { |group|
    fences = group
      .flat_map { |x, y|
        [[x + 1, y, :e], [x - 1, y, :w], [x, y + 1, :n], [x, y - 1, :s]]
          .reject { |x1, y1, dir| group.include?([x1, y1]) }
      }

    # grouping edges by columns and rows
    edges_by_dir = fences.group_by { |x, y, dir|
      [
        dir,
        (dir == :e || dir == :w) ? x : y
      ]
    }.values

    # count sides by counting discontinious sequences
    sides = edges_by_dir.sum { |edges|
      edges
        .sort_by { |x, y, d| (d == :e || d == :w) ? y : x }
        .each_cons(2)
        .select { |(x, y, d), (x1, y1)|
          if d == :e || d == :w
            y + 1 != y1
          else
            x + 1 != x1
          end
        }
        .count + 1
    }

    sides * group.count
  }
  .tap { puts _1.sum }
