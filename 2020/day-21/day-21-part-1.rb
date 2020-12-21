#!/usr/bin/env ruby

# Includes both part 1 and part 2 solutions

file_path = File.expand_path('day-21-input.txt', __dir__)
input     = File.read(file_path)

foods = input.split("\n")

all_allergens = {}
all_ingredients = []

foods.each do |food|
  ingredients, allergens = food.match(/(.+)\(contains (.+)\)/).captures

  ingredients = ingredients.split
  allergens = allergens.split(/[\s,]+/)

  allergens.each do |allergen|
    if all_allergens[allergen]
      all_allergens[allergen] = all_allergens[allergen] & ingredients
    else
      all_allergens[allergen] = ingredients
    end
  end

  all_ingredients.concat(ingredients)
end

all_allergens.values.flatten.uniq.each do |allergen|
  all_ingredients.delete(allergen)
end

puts all_ingredients.size

# Greedy works again
while all_allergens.values.map(&:size).any? { |allergen| allergen > 1 }
  all_allergens.each do |allergen, possible|
    next if possible.size > 1

    all_allergens.each do |other_allergen, other_possible|
      next if allergen == other_allergen
      other_possible.delete(possible.first)
    end
  end
end

puts all_allergens.keys.sort
  .flat_map { |allergen| all_allergens[allergen] }
  .join(?,)

