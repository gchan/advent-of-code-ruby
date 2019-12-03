#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

def walk(path)
  visited = {}
  x, y = 0, 0
  step = 1

  path.split(",").each do |instr|
    dir = instr[0]
    steps = instr[1..].to_i

    steps.times do
      case dir
      when "U"
        y += 1
      when "D"
        y -= 1
      when"L"
        x -= 1
      when "R"
        x += 1
      end

      visited[[x,y]] = step unless visited[[x,y]]
      step += 1
    end
  end

  visited
end

path_one, path_two = input.split("\n")

visited_one = walk(path_one)
visited_two = walk(path_two)

intersection = visited_one.keys & visited_two.keys

puts intersection.
  map { |x, y| visited_one[[x,y]] + visited_two[[x,y]] }.
  min
