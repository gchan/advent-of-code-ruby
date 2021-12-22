#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

packet = input.hex.to_s(2)
  .rjust(input.strip.size * 4, "0")
  .chars.map(&:to_i)

def read_packet(packet)
  version = packet.shift(3).join.to_i(2)
  type = packet.shift(3).join.to_i(2)

  subpackets = []

  case type
  when 4
    while packet.shift(5)[0] != 0
    end
  else
    if packet.shift == 0
      subpacket_length = packet.shift(15).join.to_i(2)

      subpacket = packet.shift(subpacket_length)

      while subpacket.length > 0
        version += read_packet(subpacket)
      end
    else
      num_subpackets = packet.shift(11).join.to_i(2)

      num_subpackets.times do
        version += read_packet(packet)
      end
    end
  end

  version
end

puts read_packet(packet)
