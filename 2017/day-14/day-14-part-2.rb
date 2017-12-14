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

def mark_adjacents(rows, x, y)
  queue = [[x, y]]

  while queue.length > 0
    x, y = queue.pop

    rows[y][x] = "0"

    neighbours = [
      [y + 1, x], [y - 1, x],
      [y, x + 1], [y, x - 1]
    ]

    neighbours
      .select { |y ,x| y >= 0 && y < 128 && x >= 0 && x < 128 }
      .select { |y, x| rows[y][x] == '1' }
      .each { |y, x| queue.push([x, y]) }
  end
end

rows = 128.times.map do |i|
  knot_hash("#{input}-#{i}")
    .to_i(16).to_s(2)
    .rjust(128, '0').split("")
end

groups = 0

(0..127).to_a.product((0..127).to_a).each do |x, y|
  if rows[y][x] == '1'
    mark_adjacents(rows, x, y)
    groups += 1
  end
end

puts groups
