#!/usr/bin/env ruby

file_path = File.expand_path('day-19-input.txt', __dir__)
input     = File.read(file_path)

rules, msgs = input.split("\n\n")

rule_map = {}

rules.split("\n").each do |rule|
  key, rule = rule.split(": ")

  rule.gsub!(?", "")
  rule.gsub!(/(\d+)/, '[\1]')
  rule = "(#{rule})" if rule.include? ?|

  rule_map[key] = rule
end

while rule_map[?0] =~ /\d/
  zero = rule_map[?0]
  rule = zero.scan(/\d+/)[0]
  zero.gsub!(/\[#{rule}\]/, rule_map[rule])
end

rule_map[?0].gsub!(/\s/, '')
regex = Regexp.new("^#{rule_map[?0]}$")

puts msgs.split("\n").count { |msg| regex.match(msg) }

