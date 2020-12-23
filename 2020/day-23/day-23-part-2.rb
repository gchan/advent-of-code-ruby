#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input.txt", __FILE__)
input     = File.read(file_path)

class Node
  attr_reader :num, :next

  def initialize(num)
    @num = num
  end

  def next=(node)
    @next = node
  end
end

cups = {}

ints = input.strip.chars.map(&:to_i)

num = ints.shift
curr = prev = Node.new(num)
cups[num] = curr

ints.each do |num|
  node = Node.new(num)

  prev.next = node
  prev = node
  cups[num] = node
end

(cups.size+1..1_000_000).each do |num|
  node = Node.new(num)

  prev.next = node
  prev = node
  cups[num] = node
end

prev.next = curr

10_000_000.times do
  start = curr.next
  last = curr.next.next.next

  curr.next = last.next

  nums = [start.num, start.next.num, last.num]

  dest_num = curr.num
  while
    dest_num = (dest_num - 2) % cups.size + 1
    break unless nums.include?(dest_num)
  end

  dest = cups[dest_num]

  last.next = dest.next
  dest.next = start

  curr = curr.next
end

one = cups[1]
puts one.next.num * one.next.next.num
