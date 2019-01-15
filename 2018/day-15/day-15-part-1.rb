#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

Unit = Struct.new(:x, :y, :hp, :type) do
  def elf?
    type == ?E
  end

  def enemy_type
    elf? ? ?G : ?E
  end

  def pos
    [x, y]
  end
end

map = input.split("\n").map(&:chars)

units = []

map.each.with_index do |row, y|
  row.each.with_index do |cell, x|
    case cell
    when ?.
    when ?G
      units << Unit.new(x, y, 200, cell)
    when ?E
      units << Unit.new(x, y, 200, cell)
    when ?#
    end
  end
end

# Reading order - U, L, R, D
def adjacent(x, y, map)
  [[x, y - 1], [x - 1, y], [x + 1, y], [x, y + 1]].select do |x, y|
    (0..map.length-1).cover?(y) &&
      (0..map[0].length-1).cover?(x)
  end
end

def chosen(x, y, enemy_type, map)
  bfs(x, y, map, ->(x1, y1) { map[y1][x1] == enemy_type })
end

def next_step(x, y, xt, yt, map)
  bfs(x, y, map, ->(x1, y1) { x1 == xt && y1 == yt })
end

def bfs(x, y, map, goal)
  stack = [[x, y]]
  visited = Set.new

  while stack.any?
    x, y = stack.shift

    adjacent(x, y, map).each do |x1, y1|
      return [x, y] if goal.call(x1, y1)
      next if visited.include?([x1, y1]) || map[y1][x1] != ?.
      visited.add([x1, y1])
      stack.push [x1, y1]
    end
  end
end

def print_map(map)
  puts map.map(&:join).join("\n")
end

rounds = 0

loop do
  units.sort_by { |unit| [unit.y, unit.x] }.each do |unit|
    # Chose nearest reachable position adjacent to enemy
    # (reading order breaks ties)
    chosen_pos = chosen(*unit.pos, unit.enemy_type, map)

    # Move towards the chosen position (shortest path)
    if chosen_pos && chosen_pos != unit.pos
      sx, sy = next_step(*chosen_pos, *unit.pos, map)

      map[unit.y][unit.x] = ?.
      map[sy][sx] = unit.type

      unit.x = sx
      unit.y = sy
    end

    # Target adjacent enemy with lowest hp (reading order breaks ties)
    target_unit = units
      .select { |target| target.type == unit.enemy_type }
      .select { |target| adjacent(*unit.pos, map).include?(target.pos) }
      .sort_by { |unit| [unit.hp, unit.y, unit.x] }
      .first

    # Attack if there is an adjacent enemy
    if target_unit
      target_unit.hp -= 3
      if target_unit.hp <= 0
        units.delete(target_unit)
        map[target_unit.y][target_unit.x] = ?.
      end
    end
  end

  print_map(map)

  break if units.partition(&:elf?).any?(&:empty?)

  rounds += 1
end

hp = units.map(&:hp).sum

puts rounds
puts hp

puts hp * rounds
