#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

sum = 0

input.split("\n").each do |line|
  config, digits = line.split("|").map(&:split)

  config = config.map(&:chars)
    .map(&:sort)
    .map(&:join)
    .sort_by(&:length)

  digits = digits.map(&:chars)
    .map(&:sort)
    .map(&:join)

  digit_map = []

  digit_map[1] = config[0] # len 2 => 1
  digit_map[7] = config[1] # len 3 => 7
  digit_map[4] = config[2] # len 4 => 4
  digit_map[8] = config[9] # len 7 => 8

  # Digit 4 is contained in digit 9
  #
  four = digit_map[4].chars

  nine = config.select { |digit| digit.length == 6 }
    .map(&:chars)
    .find { |digit| digit & four == four }

  digit_map[9] = nine.join

  # Digit 1 is contained in digit 3
  #
  one = digit_map[1].chars

  three = config.select { |digit| digit.length == 5 }
    .map(&:chars)
    .find { |digit| digit & one == one }

  digit_map[3] = three.join

  # Digit 5 and 1 makes digit 9
  #
  five = config.select { |digit| digit.length == 5 }
    .map(&:chars)
    .find { |digit| (digit | one).sort == nine}

  digit_map[5] = five.join

  # Digit 2 is the only remaining unidentified 5 segment piece
  #
  two = config.select { |digit| digit.length == 5 }
    .find { |digit| !digit_map.include?(digit) }

  digit_map[2] = two

  # Digit 6 and 1 makes digit 8
  #
  eight = digit_map[8].chars

  six = config.select { |digit| digit.length == 6 }
    .map(&:chars)
    .find { |digit| (digit | one).sort == eight}

  digit_map[6] = six.join

  # Digit 0 is is the last unidentified digit
  #
  zero = config
    .find { |digit| !digit_map.include?(digit) }

  digit_map[0] = zero

  config_map = Hash[*digit_map.each_with_index.to_a.flatten]

  sum += digits.map { |digit| config_map[digit] }.join.to_i
end

puts sum
