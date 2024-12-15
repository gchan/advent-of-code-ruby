#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

rules, updates = input.split("\n\n")

rules_list = Hash.new { |h, k| h[k] = Set.new }

rules.split
  .map { _1.split(?|).map(&:to_i) }
  .each { rules_list[_1].add(_2) }

updates = updates.split
  .map { _1.split(?,).map(&:to_i) }

def reorder(pages, rules_list)
  updates = []

  while pages.any?
    pages.lazy
      .select { |page|
        remain = pages.dup
        remain.delete(page)

        !remain.any? { rules_list[_1].include?(page) }
      }
      .first
      .tap { updates << pages.delete(_1) }
  end

  updates
end

updates
  .reject { |pages|
    pages.each.with_index.all? do |page, idx|
      pages[(idx + 1)..].all? { !rules_list[_1].include?(page) }
    end
  }
  .map {
    reorder(_1, rules_list)
  }
  .map { _1[_1.length / 2] }
  .inject(:+)
  .tap { puts _1 }
