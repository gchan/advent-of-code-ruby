#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

queue_one = []
queue_two = []

elf_count = input.to_i

elf_count.times do |i|
  if i < elf_count / 2
    queue_one << i + 1
  else
    queue_two << i + 1
  end
end

while queue_one.size + queue_two.size > 1
  current_elf = queue_one.shift

  if queue_one.size == queue_two.size
    queue_one.pop
  else
    queue_two.shift
  end

  queue_two << current_elf
  queue_one << queue_two.shift
end

puts queue_one
