#!/usr/bin/env ruby

file_path = File.expand_path('day-17-input.txt', __dir__)
input     = File.read(file_path)

slice = input.split("\n").map { |a| a.split("") }

slices = [slice]

def neighbours(x, y, z, slices)
  diff = [-1, 0, 1]

  diff.product(diff, diff)
    .reject { |d| d == [0,0,0] }
    .map { |dx, dy, dz| [x + dx, y + dy, z + dz] }
    .select {|x,y,z|
      (0..slices.size-1).cover?(z) &&
        (0..slices[z].size-1).cover?(y) &&
        (0..slices[z].size-1).cover?(x)
    }
end

def row(size)
  Array.new(size, ?.)
end

def slice(size)
  Array.new(size) { row(size) }
end

6.times do |i|
  size = slices[0].size + 2

  slices.each do |slice|
    slice.each do |row|
      row.unshift ?.
      row << ?.
    end

    slice.unshift row(size)
    slice << row(size)
  end

  slices.unshift slice(size)
  slices << slice(size)

  new_slices = slices.map { |slice| slice.map(&:dup) }

  slices.each_with_index do |slice, z|
    slice.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        count = neighbours(x, y, z, slices)
          .map { |x1, y1, z1| slices[z1][y1][x1] }
          .count { |c1| c1 == ?# }

        if cell == ?#
          if !(count == 2 || count == 3)
            new_slices[z][y][x] = ?.
          end
        elsif count == 3
          new_slices[z][y][x] = ?#
        end
      end
    end
  end

  slices = new_slices

  #puts "Cycle #{i + 1}"
  #slices.each_with_index do |slice, idx|
  #  puts -slice.size / 2 + 1 + idx
  #  puts slice.map(&:join).join("\n")
  #end
end

puts slices.flatten.count { |c| c == ?# }
