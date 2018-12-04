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

max_minutes = guards.map do |id, ranges|
  minute_count = Hash.new(0)

  ranges.each do |range|
    range.min...range.max do |i|
     minute_count[i] += 1
    end
  end

  minute, count = minute_count.max_by { |k, v| v }

  [id, count, minute - 1]
end

id, _, minute = max_minutes.max_by do |_id, count, _minute|
  count
end

puts id * minute
