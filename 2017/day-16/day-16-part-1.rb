#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

pro = ('a'..'p').to_a

input.split(",").each do |instr|
  case instr[0]
  when 's'
    pro.rotate!(-instr[1..-1].to_i)
  when 'x'
    a, b = instr.scan(/\d+/).map(&:to_i)
    pro[a], pro[b] = pro[b], pro[a]
  when 'p'
    a, b = instr[1..-1].scan(/\w/).map { |p| pro.index(p) }
    pro[a], pro[b] = pro[b], pro[a]
  end
end

puts pro.join
