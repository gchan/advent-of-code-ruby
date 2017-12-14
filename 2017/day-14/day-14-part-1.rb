#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

def knot_hash(input)
  lengths = input.bytes
  lengths.concat [17, 31, 73, 47, 23]

  size = 256
  list = (0..(size - 1)).to_a

  idx = 0
  skip = 0

  64.times do
    lengths.each do |length|
      list.rotate!(idx)
      list[0, length] = list[0, length].reverse
      list.rotate!(-idx)

      idx = (idx + length + skip) % size
      skip += 1
    end
  end

  list
    .each_slice(16)
    .map { |l| l.inject(:^).to_s(16).rjust(2, '0') }
    .join
end

rows = 128.times.map do |i|
  knot_hash("#{input}-#{i}")
    .to_i(16).to_s(2)
    .rjust(128, '0').split("")
end

puts rows.flatten.select{ |c| c == '1'}.length
