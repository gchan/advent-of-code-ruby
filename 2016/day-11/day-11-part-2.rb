#!/usr/bin/env ruby

# Same solution as part 1

require 'set'

file_path = File.expand_path("../day-11-input-part-2.txt", __FILE__)
input     = File.read(file_path)

class State
  attr_accessor :generators, :microchips, :elevator,
    :next_states, :steps, :state

  def initialize(generators, microchips, elevator = 0, steps = 0)
    @generators = generators
    @microchips = microchips
    @elevator   = elevator
    @steps      = steps
  end

  def valid?
    4.times.all? { |level| valid_floor?(level) }
  end

  def valid_floor?(level)
    unpowered_chips = microchips[level] - generators[level]

    unpowered_chips.none? || generators[level].count == 0
  end

  def next_states
    carry = []

    (1..2).each do |take|
      carry += generators[elevator].combination(take).map do |gens|
        { gens: gens.compact, chips: [] }
      end

      carry += microchips[elevator].combination(take).map do |chips|
        { gens: [], chips: chips.compact }
      end
    end

    carry += generators[elevator].product(microchips[elevator]).
      reject { |gen, chip| gen != chip }.
      map { |gen, chip| { gens: [gen], chips: [chip] } }

    next_floors = [elevator + 1, elevator - 1].
      reject { |floor| floor < 0 || floor > 3 }

    states = carry.product(next_floors).map do |combo, next_floor|
      new_gens = generators.map(&:clone)
      new_chips = microchips.map(&:clone)

      combo[:gens].each do |gen|
        new_gens[next_floor] << new_gens[elevator].delete(gen)
      end

      combo[:chips].each do |chip|
        new_chips[next_floor] << new_chips[elevator].delete(chip)
      end

      State.new(new_gens, new_chips, next_floor, steps + 1)
    end

    states.flatten.select(&:valid?)
  end

  def complete?
    generators[0..2].flatten.empty? && microchips[0..2].flatten.empty?
  end

  def to_s
    return @to_s if @to_s

    @to_s = generators.flatten.map do |el|
      [
        generators.find_index { |floor| floor.include?(el) },
        microchips.find_index { |floor| floor.include?(el) }
      ]
    end

    @to_s = [elevator, @to_s.sort]
  end
end

generators = []
microchips = []

input.split("\n").each.with_index do |line, idx|
  generators << line.scan(/(\w*) generator/).flatten.map { |g| g[0..1] }
  microchips << line.scan(/(\w*)-compatible microchip/).flatten.map { |m| m[0..1] }
end

starting_state = State.new(generators, microchips, 0)

queue = []
visited_states = Set.new

queue << starting_state
visited_states.add starting_state.to_s

while queue.any?
  current_state = queue.shift

  if current_state.complete?
    puts current_state.steps
    exit
  end

  current_state.next_states.each do |state|
    next if visited_states.include?(state.to_s)
    queue << state
    visited_states.add state.to_s
  end
end
