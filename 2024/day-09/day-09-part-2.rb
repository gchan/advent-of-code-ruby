#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

disk = Hash.new { |h, k| h[k] = [] }
ids = []

pos = 0

input.chars.map(&:to_i).each.with_index { |count, idx|
  range = [pos, pos + count - 1]

  if idx % 2 == 0
    disk[idx / 2] << range
    ids << idx / 2
  else
    disk[nil] << range
  end

  pos += count
}

while ids.any?
  id = ids.pop

  range = disk[id].first
  size = range.last - range.first + 1

  # Find the leftmost empty space which can hold the file
  from, to = disk[nil].find { |from, to| to - from + 1 >= size }

  # Skip if no space is found or the space is not left of the file
  next if from.nil? || from > range.first

  gap = to - from + 1

  disk[id].pop

  if gap == size
    disk[id].unshift([from, to])
    disk[nil].delete([from, to])
  elsif gap > size
    disk[id].unshift([from, from + size - 1])

    i = disk[nil].index([from, to])
    disk[nil][i]= [from + size, to]
  end

  disk[nil] << range

  ## Debugging
  # str = Array.new(pos, nil)

  # disk.each do |n, locations|
  #   locations.each do |(a, b)|
  #     (a..b).each { str[_1] = n ? n : ?. }
  #   end
  # end

  # puts str.join
end

sum = 0

disk.each do |id, locations|
  next unless id

  locations.each do |from, to|
    (from..to).each { sum += id * _1 }
  end
end

puts sum
