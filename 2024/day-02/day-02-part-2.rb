#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

reports = input.split("\n")
  .map(&:split)
  .map { _1.map(&:to_i) }

def safe?(report, can_remove = false)
  increasing = report[0] < report[1]

  report.each_cons(2).with_index do |(a, b), idx|
    if increasing != a < b || a == b || (a - b).abs > 3
      return false if !can_remove

      return safe?(report.dup.tap { _1.delete_at(idx) }) ||
        safe?(report.dup.tap { _1.delete_at(idx + 1) }) ||
        safe?(report.dup.tap { _1.delete_at(idx - 1) })
    end
  end

  true # for clarity
end

puts reports.count { safe?(_1, true) }
