#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

valves = {}
flows = {}

input.each_line do |line|
  valve = line.scan(/(\w+) has/).first.first
  leads = line.scan(/to valves? (.*)/).first.first.split(",").map(&:strip)
  flow = line.scan(/\d+/).first.to_i

  flows[valve] = flow
  valves[valve] = leads
end

# Simplify the graph by removing rooms with zero-flow valves.
#
# Do this by finding the distances between each non-zero flow valves
#
# Using the Floyd–Warshall algorithm (although it doesn't seem
# to be more efficient than a basic shortest path algorithm).
#

distances = Hash.new { |h, k| h[k] = Hash.new(9999) }

valves.each do |valve, leads|
  leads.each do |lead|
    distances[valve][lead] = 1
    distances[lead][valve] = 1
  end
end

valves.each do |inter, _|
  valves.each do |from, _|
    valves.each do |to, _|
      dist = distances[from][inter] + distances[inter][to]

      if dist < distances[from][to]
        distances[from][to] = dist
      end
    end
  end
end


# Breath-first search of the graph
#
# Keep track of the maximum pressure for each position and opened
# valves state
#

queue = [
  [
    position = "AA",  # current position
    opened = [],      # valves opened
    pressure = 0,     # total pressure if no more valves are opened
    time = 26         # time remaining
  ]
]

valves_to_open = flows.select { |_valve, flow| flow > 0 }.keys

visited = {}

while queue.any?
  curr, opened, pressure, time = queue.shift

  (valves_to_open - opened).each do |dest|
    dist = distances[curr][dest]

    n_time = time - dist - 1
    next if n_time < 0

    n_pressure = pressure + flows[dest] * n_time
    n_opened = (opened.clone << dest).sort

    next if visited[[dest, n_opened]] &&
      visited[[dest, n_opened]] > n_pressure

    visited[[dest, n_opened]] = n_pressure
    queue << [dest, n_opened, n_pressure, n_time]
  end
end

# Simplify to sets of opened valves and the maximum pressure
# released for each set of open valves.
#
# Each set represents the valves one human/elephant opened
#
opened_valves = {}

visited.each do |(_position, opened), pressure|
  next if opened_valves[opened] && pressure < opened_valves[opened]

  opened_valves[opened] = pressure
end

# Find all disjoint set pairs (where the valves opened are distinct
# amongst both sets)
#
# Return the maximum sum of each pair of disjoint sets
#
max = 0

opened_valves.each do |opened, pressure|
  opened_valves.each do |o2, p2|
    # It would be more efficient to represent the opened valves
    # as a bit set so the AND/& operation would be very cheap
    #
    if opened & o2  == []
      total = p2 + pressure

      max = [max, total].max
    end
  end
end

puts max
