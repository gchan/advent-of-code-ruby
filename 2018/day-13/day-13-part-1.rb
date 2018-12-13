#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

rows = input.split("\n")

width = rows.length
height = rows.map(&:length).max

grid = Array.new(width) { Array.new(height) }

carts = []

rows.each.with_index do |row, r|
  row.chars.each.with_index do |char, c|
    if %w(> < ^ v).include?(char)
      carts << { x: c, y: r, dir: char, inter: 0 }
      char = "-" if %w(< >).include?(char)
      char = "|" if %w(v ^).include?(char)
    end

    grid[r][c] = char
  end
end

loop do
  carts.sort_by { |cart| [cart[:y], cart[:x]] }.each do |cart|
    dir = cart[:dir]

    case dir
    when ">"
      cart[:x] += 1
    when "<"
      cart[:x] -= 1
    when "^"
      cart[:y] -= 1
    when "v"
      cart[:y] += 1
    end

    case grid[cart[:y]][cart[:x]]
    when "\\"
      case dir
      when ">"
        cart[:dir] = "v"
      when "<"
        cart[:dir] = "^"
      when "^"
        cart[:dir] = "<"
      when "v"
        cart[:dir] = ">"
      end
    when "/"
      case dir
      when ">"
        cart[:dir] = "^"
      when "<"
        cart[:dir] = "v"
      when "^"
        cart[:dir] = ">"
      when "v"
        cart[:dir] = "<"
      end
    when "+"
      case cart[:inter] % 3
      when 0
        case dir
        when ">"
          cart[:dir] = "^"
        when "<"
          cart[:dir] = "v"
        when "^"
          cart[:dir] = "<"
        when "v"
          cart[:dir] = ">"
        end
      when 2
        case dir
        when ">"
          cart[:dir] = "v"
        when "<"
          cart[:dir] = "^"
        when "^"
          cart[:dir] = ">"
        when "v"
          cart[:dir] = "<"
        end
      end

      cart[:inter] += 1
    end

    locations = carts.map { |cart| [cart[:x], cart[:y]] }

    if locations.uniq.count < locations.count
      puts "#{cart[:x]},#{cart[:y]}"
      exit
    end
  end
end
