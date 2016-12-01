#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
boss      = File.readlines(file_path)

class Spell
  attr_reader :cost, :name

  def initialize(name:, cost:)
    @name = name
    @cost = cost
  end
end

class Boss
  attr_reader :hp, :damage

  def initialize(hp:, damage:)
    @hp     = hp
    @damage = damage
  end

  def damaged(damage)
    @hp -= damage
  end

  def dead?
    hp <= 0
  end
end

class Wizard
  attr_reader :hp, :mana, :armor,
    :shield_timer, :poison_timer, :recharge_timer,
    :spent_mana

  def initialize(hp:, mana:)
    @hp   = hp
    @mana = mana

    @armor          = 0
    @spent_mana     = 0
    @shield_timer   = 0
    @poison_timer   = 0
    @recharge_timer = 0
  end

  def damaged(damage)
    @hp -= [damage - armor, 1].max
  end

  def dead?
    hp <= 0 || mana < 53
  end

  def cast(spell, boss)
    @spent_mana += spell.cost
    @mana       -= spell.cost

    case spell.name
    when :missile
      boss.damaged(4)
    when :drain
      boss.damaged(2)
      @hp += 2
    when :shield
      @armor        = 7
      @shield_timer = 6
    when :poison
      @poison_timer = 6
    when :recharge
      @recharge_timer = 5
    end
  end

  def can_cast?(spell)
    return false if spell.cost > mana
    case spell.name
    when :shield
      shield_timer == 0
    when :poison
      poison_timer == 0
    when :recharge
      recharge_timer == 0
    else
      true
    end
  end

  def tick(boss)
    if shield_timer > 0
      @shield_timer -= 1
    else
      @armor = 0
    end

    if poison_timer > 0
      boss.damaged(3)
      @poison_timer -= 1
    end

    if recharge_timer > 0
      @mana += 101
      @recharge_timer -= 1
    end
  end
end

spells = [
  Spell.new(name: :missile,  cost: 53),
  Spell.new(name: :drain,    cost: 73),
  Spell.new(name: :shield,   cost: 113),
  Spell.new(name: :poison,   cost: 173),
  Spell.new(name: :recharge, cost: 229)
]

boss_hp     = boss[0].scan(/\d+/).first.to_i
boss_damage = boss[1].scan(/\d+/).first.to_i

# This could *definitely* be improved

min_mana = 9_000

200_000.times do
  boss   = Boss.new(hp: boss_hp, damage: boss_damage)
  wizard = Wizard.new(hp: 50, mana: 500)

  wizard.damaged(1)

  while !wizard.dead?
    wizard.tick(boss)

    spell = spells.sample
    while !wizard.can_cast?(spell)
      spell = spells.sample
    end

    wizard.cast(spell, boss)
    wizard.tick(boss)

    if boss.dead?
      if wizard.spent_mana <= min_mana
        min_mana = wizard.spent_mana
        puts min_mana
      end
      break
    end

    wizard.damaged(boss.damage)
    wizard.damaged(1)
  end
end
