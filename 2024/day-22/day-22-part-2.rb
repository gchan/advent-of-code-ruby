#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

input.split.map(&:to_i)
  .map {
    s = _1

    seqs = {}
    diffs = []

    2000.times {
      ns = s.*(64).^(s).%(16777216)
      ns = ns./(32).^(ns).%(16777216)
      ns = ns.*(2048).^(ns).%(16777216)

      diffs << (ns % 10 - s % 10)
      diffs = diffs[-4..] if diffs.length > 4

      if diffs.length == 4
        seqs[diffs.join(?,)] ||= ns % 10
      end

      s = ns
    }

    seqs
  }
  .inject({}) { |sums, seqs|
    seqs.each do |seq, sum|
      sums[seq] ||= 0
      sums[seq] += sum
    end

    sums
  }
  .tap { p _1.values.max }
