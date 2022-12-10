#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

directories = Hash.new { |h, k| h[k] = [] }

current_dir = []

input.each_line do |line|
  case line.split
  in [/\d+/ => size, _file]
    directories[current_dir.clone] << size.to_i
  in ["dir", /\w+/ => dir]
    new_dir = current_dir.clone.append(dir)
    directories[current_dir.clone] << directories[new_dir]
  in ["$", "cd", ".."]
    current_dir.pop
  in ["$", "cd", /.+/ => dir]
    current_dir << dir
  else # ls
  end
end

total_space = 70_000_000
target_free_space = 30_000_000
used_space = directories[["/"]].flatten.sum
minimum_to_delete = target_free_space - (total_space - used_space)

puts directories.map { |_k, v| v.flatten.sum }
  .select { |size| size >= minimum_to_delete }
  .min
