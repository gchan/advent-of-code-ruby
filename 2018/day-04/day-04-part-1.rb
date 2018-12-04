#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

guard_logs = input.split("\n").sort.
  slice_before { |l| l.include?("begin") }

guards = Hash.new { |h, k| h[k] = [] }

guard_logs.each do |logs|
  id = logs.shift.scan(/#(\d*)/)[0][0].to_i

  logs.each_slice(2) do |asleep, wake|
    h, m = asleep.scan(/(\d*):(\d*)/)[0]
    start = h.to_i * 60 + m.to_i

    h, m = wake.scan(/(\d*):(\d*)/)[0]
    stop = h.to_i * 60 + m.to_i

    guards[id] << (start..stop)
  end
end

id, _ = guards.max_by do |id, sleeps|
  sleeps.map(&:size).inject(:+)
end

minute_counts = Hash.new(0)

guards[id].each do |range|
  range.min...range.max do |i|
    minute_counts[i] += 1
  end
end

minute, _ = minute_counts.max_by { |_minute, count| count }

puts id * (minute - 1)
