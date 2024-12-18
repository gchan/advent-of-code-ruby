#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

disk = Hash.new { |h, k| h[k] = [] }
ids = []

pos = 0
capacity = 0

input.chars.map(&:to_i).each.with_index { |count, idx|
  range = [pos, pos + count - 1]

  if idx % 2 == 0
    disk[idx / 2] << range
    capacity += count
    ids << idx / 2
  else
    disk[nil] << range
  end

  pos += count
}

# keep going until disk is compacted
while disk[nil][0][0] <= capacity
  from, to = disk[nil].shift
  gap = to - from + 1

  id = ids.pop

  range = disk[id].last
  size = range.last - range.first + 1

  if gap == size # simple move
    disk[id].unshift([from, to])
    disk[id].pop
  elsif gap < size # slice the file
    disk[id].unshift([from, to])
    disk[id][-1] = [range.first, range.last - gap]
    ids << id
  else # gap > size; there is still a gap
    disk[id].unshift([from, from + size - 1])
    disk[id].pop
    disk[nil].unshift([from + size, to])
  end
end

sum = 0

disk.delete(nil)

disk.each do |id, locations|
  locations.each do |from, to|
    (from..to).each { sum += id * _1 }
  end
end

puts sum
