#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
input     = File.read(file_path)

boxes = Hash.new { |h, k| h[k] = [] }

input
  .strip
  .split(",")
  .each {
    label = _1.scan(/\w*/).first

    bi = label.chars.inject(0) { |bi, chr|
      bi += chr.ord
      bi *= 17
      bi %= 256
    }

    box = boxes[bi]

    op, fl = _1.strip.chars[label.length..]
    fl = fl.to_i

    idx = box.index { |lab, _| lab == label }

    if op == ?-
      box.delete_at(idx) if idx
    elsif idx
      box[idx] = [label, fl]
    else
      box << [label, fl]
    end
  }

boxes
  .sum { |box, lenses|
    lenses.each.with_index.sum { |(_, fl), idx|
      (box + 1) * (idx + 1) * fl
    }
  }
  .tap { puts _1 }
