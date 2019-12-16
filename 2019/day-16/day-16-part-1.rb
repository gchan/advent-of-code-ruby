#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

base = [0, 1, 0, -1]

digits = input.to_i.digits.reverse

100.times do |time|
  result = []

  digits.length.times do |i|
    sum = 0

    # 5 x slower solution - but simplier
    # digits.length.times do |idx|
    #   sum += digits[idx] * base[(idx + 1) / (i + 1) % base.length]
    # end

    # This observation is very important for part 2 :)
    last_relevant_digit = digits.length - 1

    if ((i + 1) * 3) > digits.length
      last_relevant_digit = [
        (i + 1) * 2 - 1,
        last_relevant_digit
      ].min
    end

    digits[i..last_relevant_digit].each_slice(i + 1)
      .with_index do |slice, idx|

      total = slice.inject(:+)

      case idx % 4
      when 0 # 1
        sum += total
      when 2 # -1
        sum -= total
      end
    end

    result << sum.abs % 10
  end

  digits = result
end

puts digits[0, 8].join

