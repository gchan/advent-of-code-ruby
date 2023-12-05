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

def overlapping_range(a, b)
  if b.begin <= a.end && a.begin <= b.end
    [a.begin, b.begin].max..[a.end, b.end].min
  end
end

seed_ranges = seeds.each_slice(2).map do |from, length|
  from..(from + length)
end

maps
  .reduce(seed_ranges) { |sources, map|
    sources.flat_map { |source_range|
      destinations = []

      curr = source_range.begin

      map
        .sort_by { |range, offset| range.begin }
        .each { |range, offset|
          matching_range = overlapping_range(range, source_range)

          if matching_range
            if matching_range.begin != curr
              # This doesn't seem to be required for my given input
              # but I _think_ this is required for sources where there
              # is no mapping
              destinations << (curr..(matching_range.begin - 1))
            end

            destinations << (
              (matching_range.begin + offset)..(matching_range.end + offset)
            )
            curr = matching_range.end + 1
          end
        }

      if curr < source_range.end
        destinations << (curr..source_range.end)
      end

      destinations
    }
  }
  .min_by(&:begin)
  .begin
  .tap { puts _1 }
