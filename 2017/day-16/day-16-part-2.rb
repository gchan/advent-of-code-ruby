#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

pro = ('a'..'p').to_a

visited = {}

dance = 0

until visited[pro.join]
  visited[pro.join] = dance
  dance += 1

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
end

puts visited.to_a.map(&:reverse)
  .sort.map(&:last)
  .fetch(1_000_000_000 % visited.size)
