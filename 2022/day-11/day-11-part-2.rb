#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

Monkey = Struct.new(:items, :op, :op_val, :test, :t_true, :t_false, :inspected) do
  def initialize(*)
    super
    self.inspected = 0
  end
end

monkeys = []

input.each_line.each_slice(7) do |lines|
  _, items, op_str, test, t_true, t_false = lines.map(&:strip)

  items = items.scan(/\d+/).map(&:to_i)
  op = op_str.scan(/\*|\+/).first
  op_val = op_str.scan(/\d+/).first

  # handle old * old
  if op_val.nil?
    op = "**"
    op_val = 2
  else
    op_val = op_val.to_i
  end

  test = test.scan(/\d+/).first.to_i
  t_true = t_true.scan(/\d+/).first.to_i
  t_false = t_false.scan(/\d+/).first.to_i

  monkeys << Monkey.new(items, op, op_val, test, t_true, t_false)
end

# https://en.wikipedia.org/wiki/Least_common_multiple
# Note the numbers are all primes
divisor = monkeys.map(&:test).inject(&:*)

10_000.times do |i|
  monkeys.each do |monkey|
    monkey.items.each do |item|
      monkey.inspected += 1

      worry = item.send(monkey.op, monkey.op_val) % divisor

      if worry % monkey.test == 0
        monkeys[monkey.t_true].items << worry
      else
        monkeys[monkey.t_false].items << worry
      end
    end

    monkey.items = []
  end
end

pp monkeys.map(&:inspected).sort.last(2).inject(&:*)
