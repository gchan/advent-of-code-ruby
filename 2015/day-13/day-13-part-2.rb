#!/usr/bin/env ruby

# 8 guests so we can brute force
# !9 = 362880 possible seating arrangements
# Some seating arrangements are essentially the same for the purpose of this problem

file_path = File.expand_path("../day-13-input.txt", __FILE__)
rules     = File.readlines(file_path)

happiness_rules = Hash.new { |hash, key| hash[key] = Hash.new(0) }

rules.each do |rule|
  person    = rule.scan(/\A\w*/).first
  next_to   = rule.scan(/(\w*)\./).first.first
  happiness = rule.scan(/\d+/).first.to_i
  negative  = rule.scan('lose').any?

  happiness = -happiness if negative

  happiness_rules[person][next_to] = happiness
end

guests = happiness_rules.keys << "Me"

happiness_changes = guests.permutation.map do |seating|
  seating = seating.push(seating.first)
  seating.each_cons(2).inject(0) do |total, (person, next_to)|
    total + happiness_rules[person][next_to] + happiness_rules[next_to][person]
  end
end

puts happiness_changes.max
