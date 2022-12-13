#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.split("\n").map(&:chars)

y = grid.find_index { |row| row.include?("E") }
x = grid[y].find_index { |cell| cell == "E" }

visited = {}

queue = [[x, y, 0, ?z]]

def neighbours(x, y)
  [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].select do |x, y|
    x >= 0 && y >= 0
  end
end

while queue.any?
  x, y, d, h = queue.shift

  neighbours(x, y).each do |x1, y1|
    h1 = grid[y1]&.[](x1)

    next unless h1
    next if h1.next < h

    d1 = d + 1

    if h1 == 'a'
      puts d1
      exit
    elsif !visited[[x1, y1]]
      queue << [x1, y1, d1, h1]
      visited[[x1, y1]] = d1
    else
      d2 = visited[[x1, y1]]
      visited[[x1, y1]] = [d1, d2].min
    end
  end
end
