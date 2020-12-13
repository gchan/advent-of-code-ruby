#!/usr/bin/env ruby

file_path = File.expand_path('day-13-input.txt', __dir__)
input     = File.read(file_path)

buses = input.split("\n").last.split(?,)

ids = buses
  .map.with_index { |id, idx| [id.to_i, idx] }
  .reject { |id, _| id.zero? }
  .sort.reverse

id, idx = ids.first

# Solve for the first bus, and time step for the next valid timestamp
t = id - idx
step = id

# Solve for each additional bus
ids.each do |id, idx|
  while true
    break if (t + idx) % id == 0
    t += step
  end

  # Find next time step for this subset of buses by locating the next timestamp
  # OR simply `step *= id` if you know you are dealing only with prime numbers
  t2 = t
  subset = ids[0..(ids.index([id, idx]))]
  while true
    t2 += step
    break if subset.all? { |id, i| (t2 + i) % id  == 0 }
  end

  step = t2 - t
end

puts t

exit

# Solution below is too slow for non-example input
ids = buses
  .map.with_index { |id, idx| [id.to_i, idx] }
  .reject { |id, _| id.zero? }
  .sort

step = ids.last[0]
adj = ids.last[1]

t = step - adj

while true
  break if ids.all? { |id, i| (t + i) % id  == 0 }

  t += step
end

puts t
