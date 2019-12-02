#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

codes = input.split(",").map(&:to_i)

def run(noun, verb, codes)
  codes[1] = noun
  codes[2] = verb

  i = 0

  loop do
    case codes[i]
    when 1
      op = :+
    when 2
      op = :*
    when 99
      return codes[0]
    end

    codes[codes[i+3]] = codes[codes[i+1]].send(op, codes[codes[i+2]])

    i += 4
  end
end

100.times do |n|
  100.times do |v|
    result = run(n, v, codes.clone)
    if result == 19690720
      puts 100 * n + v
      exit
    end
  end
end
