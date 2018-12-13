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
      carts << { x: c, y: r, dir: char, inter: 0, id: carts.length, crashed: false }
      char = "-" if %w(< >).include?(char)
      char = "|" if %w(v ^).include?(char)
    end

    grid[r][c] = char
  end
end

while carts.count { |c| !c[:crashed] } > 1 do
  carts.sort_by! { |cart| [cart[:y], cart[:x]] }

  carts.reject { |c| c[:crashed] }.each do |cart|
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

    other = carts
      .reject { |c| c[:crashed] }
      .reject { |c| c[:id] == cart[:id] }
      .find { |c| c[:x] == cart[:x] && c[:y] == cart[:y] }

    if other
      other[:crashed] = true
      cart[:crashed] = true
    end
  end
end

final_cart = carts.find { |c| !c[:crashed] }

puts "#{final_cart[:x]},#{final_cart[:y]}"