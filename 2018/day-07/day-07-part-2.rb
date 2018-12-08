#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

rules = input.split("\n")

steps = Hash.new { |h, k| h[k] = Array.new }

rules.each do |rule|
  req, step = rule.scan(/\s(\w)\s/).map(&:first)

  steps[step] << req
end

todo = ("A"..(steps.keys.max)).to_a

num_workers = 5
workers = {}

tick = -1

while todo.any? || workers.any?
  tick += 1

  workers.keys.each do |step|
    workers[step] -= 1

    next if workers[step] > 0

    # Mark job as complete
    steps.each do |key, value|
      value.delete(step)
    end

    workers.delete(step)
  end

  # Assign available jobs to available workesr
  if workers.count < num_workers
    todo.each do |step|
      next if steps[step].any?

      todo.delete(step)

      job_length = step.ord - "A".ord + 1 + 60
      workers[step] = job_length
    end
  end
end

puts tick
