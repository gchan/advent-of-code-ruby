#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

packet = input.hex.to_s(2)
  .rjust(input.strip.size * 4, "0")
  .chars.map(&:to_i)

def read_packet(packet)
  version = packet.shift(3).join.to_i(2)
  type = packet.shift(3).join.to_i(2)

  if type == 4 # Literal
    bits = []

    while true
      group = packet.shift(5)
      bits << group[1..]

      break if group[0] == 0
    end

    return bits.flatten.join.to_i(2)
  end

  literals = []

  if packet.shift == 0
    subpacket_length = packet.shift(15).join.to_i(2)

    subpacket = packet.shift(subpacket_length)

    while subpacket.length > 0
      literals << read_packet(subpacket)
    end
  else
    num_subpackets = packet.shift(11).join.to_i(2)

    num_subpackets.times do
      literals << read_packet(packet)
    end
  end

  case type
  when 0 # Sum
    literals.sum
  when 1 # Product
    literals.inject(:*)
  when 2 # Min
    literals.min
  when 3 # Max
    literals.max
  when 5 # Greater than
    literals.inject(:>) ? 1 : 0
  when 6 # Less than
    literals.inject(:<) ? 1 : 0
  when 7 # Equal
    literals.inject(:==) ? 1 : 0
  end
end

puts read_packet(packet)
