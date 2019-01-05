#!/usr/bin/env ruby

# Includes solution for part 2

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input = File.read(file_path)

class Group
  attr_reader :units, :initiative, :attack, :infection

  def initialize(units, health, weak, immune, attack, damage, initiative, infection, boost = 0)
    @units      = units
    @health     = health
    @weak       = weak || []
    @immune     = immune || []
    @attack     = attack
    @damage     = damage + boost
    @initiative = initiative
    @infection  = infection == :infection
  end

  def effective_power
    @units * @damage
  end

  def potential_damage(attacker)
    damage_points = attacker.effective_power
    type = attacker.attack

    if @immune.include?(type)
      0
    elsif @weak.include?(type)
      damage_points * 2
    else
      damage_points
    end
  end

  def attacked(attacker)
    damage_taken = potential_damage(attacker)

    units_lost = damage_taken / @health

    @units = [units - units_lost, 0].max

    units_lost
  end
end

def parse_group(group_string, infection, boost = 0)
  units, health, damage, attack, initiative =
    group_string.scan(/(\d+).*with (\d+).*does (\d+) (.*) damage.*initiative (\d+)/)[0]

  units = units.to_i
  health = health.to_i
  damage = damage.to_i
  initiative = initiative.to_i

  immune = group_string.scan(/immune to ([\w, ]*)/)[0]
  immune = immune[0].split(", ") if immune

  weak = group_string.scan(/weak to ([\w, ]*)/)[0]
  weak = weak[0].split(", ") if weak

  Group.new(units, health, weak, immune, attack, damage, initiative, infection, boost)
end

def solve(input, boost = 0)
  immune, infection = input.split("\n\n")

  groups = []

  immune.split("\n")[1..-1].map do |group|
    groups << parse_group(group, :immune, boost)
  end

  infection = infection.split("\n")[1..-1].map do |group|
    groups << parse_group(group, :infection)
  end

  while groups.select(&:infection).any? && groups.reject(&:infection).any?
    targets = {}

    groups
      .sort_by { |group| [-group.effective_power, -group.initiative] }
      .each { |attacking|
        target = groups
          .reject { |group| group.infection == attacking.infection }
          .reject { |group| targets[group] }
          .max_by { |defending|
            [
              defending.potential_damage(attacking),
              defending.effective_power,
              defending.initiative
            ]
          }

        next unless target && target.potential_damage(attacking) > 0

        targets[target] = attacking
      }

    units_lost = targets
      .sort_by { |_, attacking| -attacking.initiative }
      .map { |defending, attacking| defending.attacked(attacking) }

    return [] if units_lost.inject(:+) == 0

    groups.reject! { |group| group.units == 0 }
  end

  groups
end

# Part 1
puts solve(input).map(&:units).inject(:+)

# Part 2
min = 0
max = 10_000

while max > min
  mid = (min + max) / 2

  if solve(input, mid).reject(&:infection).any?
    max = mid
  else
    min = mid + 1
  end
end

puts solve(input, min).reject(&:infection).map(&:units).inject(:+) || 0
