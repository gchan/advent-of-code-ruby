#!/usr/bin/env ruby

# Same as day-08-part-1.rb

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

pixels = Array.new(6) { Array.new(50, ' ') }

lines = input.split("\n")

lines.each do |line|
  if line =~ /rect/
    x, y = line.split(" ").last.split("x").map(&:to_i)

    y.times do |y1|
      x.times do |x1|
        pixels[y1][x1] = "#"
      end
    end

  else # rotate
    by = line.match(/by (\d*)/)[1].to_i

    if line =~ /row/
      row = line.match(/=(\d*)/)[1].to_i
      pixels[row].rotate!(-by)
    else # column
      col = line.match(/=(\d*)/)[1].to_i
      pixels = pixels.transpose
      pixels[col].rotate!(-by)
      pixels = pixels.transpose
    end
  end
end

# upojflbcez
puts pixels.map(&:join).join("\n")

puts pixels.flatten.count { |pixel| pixel == '#' }
