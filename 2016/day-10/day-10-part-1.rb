#!/usr/bin/env ruby

# Includes solution for part 2

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

bots         = Hash.new { |h, k| h[k] = [] }
instructions = Hash.new { |h, k| h[k] = [] }
outputs      = Hash.new { |h, k| h[k] = [] }

lines = input.split("\n")

lines.select { |line| line.start_with?('value') }.each do |value|
  chip = value.match(/value (\d*)/)[1].to_i
  bot  = value.match(/bot (\d*)/)[1]

  bots[bot] << chip
end

lines.select { |line| line.start_with?('bot') }.each do |value|
  bot = value.match(/bot (\d*)/)[1]
  low = value.match(/low to (bot|output) (\d*)/)
  high = value.match(/high to (bot|output) (\d*)/)

  low_out = low[1] == 'bot' ? bots[low[2]] : outputs[low[2]]
  high_out = high[1] == 'bot' ? bots[high[2]] : outputs[high[2]]

  instructions[bot][0] = low_out
  instructions[bot][1] = high_out
end

while bots.any? { |_, chips| chips.size == 2 } do
  bots.select { |_, chips| chips.size == 2 }.each do |bot, chips|
    chips.sort!

    puts bot if chips == [17, 61]

    instructions[bot][0] << chips[0]
    instructions[bot][1] << chips[1]

    bots[bot] = []
  end
end

puts outputs["0"][0] * outputs["1"][0] * outputs["2"][0]
