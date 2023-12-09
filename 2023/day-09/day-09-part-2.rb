#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

input.each_line
  .sum { | line|
    i = line.split.map(&:to_i)

    seqs = [i]

    while !seqs.last.all?(&:zero?)
      seqs << seqs.last.each_cons(2).map { _2 - _1 }
    end

    seqs.reverse_each.with_index { |seq, idx|
      if idx.zero?
        seq.unshift(0)
      else
        seq.unshift(seq.first - seqs[-idx].first)
      end
    }

    seqs.first.first
  }
  .tap { puts _1 }
