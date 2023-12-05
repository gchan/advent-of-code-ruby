#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

seeds, *maps = input.split("\n\n")

seeds = seeds.scan(/\d+/).map(&:to_i)

maps.map! {
  map = {}

  _1.split("\n")[1..-1].each do |line|
    dest, source, length = line.split.map(&:to_i)

    range = source..(source + length)
    offset = dest - source

    map[range] = offset
  end

  map
}

seeds
  .map { |source|
    maps.reduce(source) do |source, map|
      range, offset = map.find do |range, offset|
        range.include?(source)
      end

      source += offset if range
      source
    end
  }
  .min
  .tap { puts _1 }
