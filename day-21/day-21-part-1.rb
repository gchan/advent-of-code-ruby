#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
boss      = File.readlines(file_path)

# OO Overboard
class Person
  attr_reader :hp, :damage, :armor

  def initialize(hp, damage, armor)
    @hp     = hp
    @damage = damage
    @armor  = armor
  end
end

class Item
  attr_reader :cost, :damage, :armor

  def initialize(cost:, damage: 0, armor: 0)
    @cost   = cost
    @damage = damage
    @armor  = armor
  end
end

weapons = [
  Item.new(cost: 8,  damage: 4),
  Item.new(cost: 10, damage: 5),
  Item.new(cost: 25, damage: 6),
  Item.new(cost: 40, damage: 7),
  Item.new(cost: 74, damage: 8)
]

# One null object
armor = [
  Item.new(cost: 0,   armor: 0),
  Item.new(cost: 13,  armor: 1),
  Item.new(cost: 31,  armor: 2),
  Item.new(cost: 53,  armor: 3),
  Item.new(cost: 75,  armor: 4),
  Item.new(cost: 102, armor: 5),
]

# Two null objects
rings = [
  Item.new(cost: 0,   armor: 0),
  Item.new(cost: 0,   armor: 0),
  Item.new(cost: 25,  damage: 1),
  Item.new(cost: 50,  damage: 2),
  Item.new(cost: 100, damage: 3),
  Item.new(cost: 20,  armor: 1),
  Item.new(cost: 40,  armor: 2),
  Item.new(cost: 80,  armor: 3)
]

def win?(hero, boss)
  turns_to_defeat = (boss.hp.to_f / [(hero.damage - boss.armor), 1].max).ceil
  turns_to_lose   = (hero.hp.to_f / [(boss.damage - hero.armor), 1].max).ceil

  turns_to_defeat <= turns_to_lose
end

boss_hp     = boss[0].scan(/\d+/).first.to_i
boss_damage = boss[1].scan(/\d+/).first.to_i
boss_armor  = boss[2].scan(/\d+/).first.to_i

boss = Person.new(boss_hp, boss_damage, boss_armor)

combinations = weapons.product(armor, rings.combination(2).to_a)

winning_costs = combinations.map do |items|
  items.flatten!
  cost   = items.map(&:cost).inject(0, :+)
  damage = items.map(&:damage).inject(0, :+)
  armor  = items.map(&:armor).inject(0, :+)

  hero = Person.new(100, damage, armor)

  if win?(hero, boss)
    cost
  else
    nil
  end
end

puts winning_costs.compact.min
