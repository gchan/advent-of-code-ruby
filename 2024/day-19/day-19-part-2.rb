#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

towels, designs = input.split("\n\n")

towels = Set.new(towels.split(?,).map(&:strip))
designs = designs.split("\n")

def path_count(design, towels, cache)
  return 1 if design.empty?

  cache[design] ||= towels
    .select { |towel| design.start_with?(towel) }
    .sum { |towel| path_count(design[towel.length..], towels, cache) }
end

cache = {}

designs
  .sum { path_count(_1, towels, cache) }
  .tap { puts _1 }

# Fast enough for sample input, too slow for larger inputs
#
# designs.sum {
#   queue = [_1]
#   count = 0
#
#   while queue.any?
#     design = queue.shift
#
#     towels
#       .select { |towel| design.start_with?(towel) }
#       .each { |towel|
#         if towel == design
#           count += 1
#         else
#           queue.unshift(design[towel.length..])
#         end
#       }
#   end
#
#   count
# }.tap { puts _1 }
