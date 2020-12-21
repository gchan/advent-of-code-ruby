#!/usr/bin/env ruby

file_path = File.expand_path('day-18-input.txt', __dir__)
input     = File.read(file_path)

lines = input.split("\n")

sum = 0

def sum(exp)
  result = exp.shift.to_i

  exp.each_slice(2) do |op, num|
    result = result.send(op, num.to_i)
  end

  result
end

lines.each do |line|
  tokens = line.gsub(/\s/, '').chars

  stack = []

  tokens.each do |token|
    if token =~ /[\d\*\+\(]+/
      stack << token
    else # ?(
      exp = []

      while stack.last != ?(
        exp << stack.pop
      end
      stack.pop # ?(

      result = sum(exp.reverse)

      stack << result
    end
  end

  sum += sum(stack)
end

puts sum
