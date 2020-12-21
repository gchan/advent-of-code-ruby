#!/usr/bin/env ruby

file_path = File.expand_path('day-18-input.txt', __dir__)
input     = File.read(file_path)

lines = input.split("\n")

sum = 0

lines.each do |line|
  tokens = line.gsub(/\s/, '').chars

  stack = []

  tokens.each do |token|
    if token =~ /\d/
      stack << token.to_i
    elsif token =~ /[\+\*\(]+/
      stack << token
    else # ?(
      exp = []

      while stack.last != ?(
        exp << stack.pop
      end
      stack.pop # ?(

      result = eval(exp.join)

      stack << result
    end

    while stack.last.is_a?(Integer) && stack[-2] == ?+
      num1 = stack.pop
      stack.pop # ?+
      num2 = stack.pop

      stack << num1 + num2
    end
  end

  sum += eval(stack.reverse.join)
end

puts sum
