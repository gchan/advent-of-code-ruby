#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input     = File.read(file_path)

schematics = input.split("\n\n")
  .map(&:split)

locks = schematics.select { _1.first.include?(?#) }
keys  = schematics.select { _1.last.include?(?#) }

locks = locks.map { |lock|
  lock.map(&:chars).transpose.map { _1.count { |col| col.include? ?# } - 1 }
}

keys = keys.map { |key|
  key.map(&:chars).transpose.map { _1.count { |col| col.include? ?# } - 1 }
}

keys.product(locks)
  .count { |key, lock| key.zip(lock).all? { _1 + _2 <= 5 } }
  .tap { p _1 }
