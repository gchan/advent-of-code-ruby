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

puts directories.map { |_k, v| v.flatten.sum }
  .select { |size| size <= 100_000 }
  .sum
