#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

devices = input
  .split("\n")
  .map {
    src, *dest = _1.split(/: | /)

   [src, dest]
  }
  .to_h

count = 0
queue = [["you"]]

while queue.any?
  path = queue.shift
  current = path.last

  devices[current].each do |neighbour|
    new_path = path + [neighbour]

    if neighbour == "out"
      count += 1
    else
      queue << new_path
    end
  end
end

puts count

# Recursive DFS solution
def dfs(input, devices)
  return 1 if input == "out"

  devices[input].sum do |output|
    dfs(output, devices)
  end
end

puts dfs("you", devices)
