#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

machines = input.split("\n\n")

machines
  .map { |machine|
    ax, ay, bx, by, px, py = machine.scan(/\d+/).map(&:to_i)

    sa = 0
    sb = 0

    max_b = [
      px / bx,
      py / by,
      100
    ].min

    (0..max_b).reverse_each { |b|
      ry = (py - b * by)
      next if ry % ay != 0

      a = ry / ay
      next if a > 100

      rx = (px - b * bx)
      next unless rx == 0 || (rx / a.to_f == ax)

      sa = a
      sb = b
      break
    }

    sa * 3 + sb
  }
  .sum
  .tap { puts _1 }
