#!/usr/bin/env ruby

file_path = File.expand_path('day-17-input.txt', __dir__)
input     = File.read(file_path)

slice = input.split("\n").map { |a| a.split("") }

size = slice.length

cubes = [[slice]]

def neighbours(x, y, z, w, cubes)
  diff = [-1, 0, 1]

  diff.product(diff, diff, diff)
    .reject { |d| d == [0, 0, 0, 0] }
    .map { |dx, dy, dz, dw| [x + dx ,y + dy, z + dz, w + dw] }
    .select {|x,y,z,w|
      (0..cubes.size-1).cover?(w) &&
        (0..cubes[w].size-1).cover?(z) &&
        (0..cubes[w][z].size-1).cover?(y) &&
        (0..cubes[w][z].size-1).cover?(x)
    }
end

def row(size)
  Array.new(size, ?.)
end

def slice(size)
  Array.new(size) { row(size) }
end

def cube(size)
  Array.new(size - 2) { slice(size) }
end

6.times do |i|
  size += 2

  cubes.each do |cube|
    cube.each do |slice|
      slice.each do |row|
        row.unshift ?.
        row << ?.
      end

      slice.unshift row(size)
      slice << row(size)
    end

    cube.unshift slice(size)
    cube << slice(size)
  end

  cubes.unshift cube(size)
  cubes << cube(size)

  new_cubes = cubes.map { |slice| slice.map { |s| s.map(&:dup) } }

  cubes.each_with_index do |cube, w|
    cube.each_with_index do |slice, z|
      slice.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          count = neighbours(x, y, z, w, cubes)
            .map { |x1, y1, z1, w1| cubes[w1][z1][y1][x1] }
            .count { |c1| c1 == ?# }

          if cell == ?#
            if !(count == 2 || count == 3)
              new_cubes[w][z][y][x] = ?.
            end
          elsif count == 3
            new_cubes[w][z][y][x] = ?#
          end
        end
      end
    end
  end

  cubes = new_cubes

  #puts "Cycle #{i + 1}"
  #cubes.each_with_index do |cube, w|
  #  cube.each_with_index do |slice, z|
  #    puts [-cube.size / 2 + 1 + z, -cubes.size / 2 + 1 + w].inspect
  #    puts slice.map(&:join).join("\n")
  #  end
  #end
end

puts cubes.flatten.count { |c| c == ?# }
