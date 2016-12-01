#!/usr/bin/env ruby

file_path   = File.expand_path("../day-15-input.txt", __FILE__)
ingredients = File.readlines(file_path)

class Ingredient
  attr_reader :capacity, :durability, :flavor, :texture, :calories

  def initialize(capacity:, durability:, flavor:, texture:, calories:)
    @capacity   = capacity
    @durability = durability
    @flavor     = flavor
    @texture    = texture
    @calories   = calories
  end

  def multiply(teaspoons)
    Ingredient.new(
      capacity:   teaspoons * capacity,
      durability: teaspoons * durability,
      flavor:     teaspoons * flavor,
      texture:    teaspoons * texture,
      calories:   teaspoons * calories
    )
  end
end

ingredients.map! do |ingredient|
  Ingredient.new(
    capacity:   ingredient.match(/capacity (-*\d+)/)[1].to_i,
    durability: ingredient.match(/durability (-*\d+)/)[1].to_i,
    flavor:     ingredient.match(/flavor (-*\d+)/)[1].to_i,
    texture:    ingredient.match(/texture (-*\d+)/)[1].to_i,
    calories:   ingredient.match(/calories (-*\d+)/)[1].to_i
  )
end

best = 0

0.upto(100) do |a|
  0.upto(100 - a) do |b|
    0.upto(100 - a - b) do |c|
      d = 100 - a - b - c

      amounts = [a, b, c, d]

      recipie = ingredients.zip(amounts).
        map { |ingredient, teaspoons| ingredient.multiply(teaspoons) }

      properties = recipie.map do |ingredient|
        [
          ingredient.capacity,
          ingredient.durability,
          ingredient.flavor,
          ingredient.texture
        ]
      end

      score = properties.inject(&:zip).
        map { |property| property.flatten.inject(:+) }.
        map { |value| [value, 0].max }.
        inject(:*)

      if score > best && recipie.map(&:calories).inject(:+) == 500
        best = score
      end
    end
  end
end

puts best
