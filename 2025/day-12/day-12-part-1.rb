#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

shapes = input.split("\n\n")

regions = shapes.pop.split("\n")
  .map {
    size, shape_qty = _1.split(?:)

    [
      size.split(?x).map(&:to_i),
      shape_qty.split.map(&:to_i)
    ]
  }

shapes.map! {
  _, *shape = _1.split(?\n)

  shape.join
}

# Cheeky solution - just compare areas
# Only works with the input provided and not the sample input
shape_areas = shapes.map.with_index { |shape, idx|
  shape.chars.count { _1 == ?# }
}

regions
  .count { |(size_x, size_y), shape_qty|
    total_area = size_x * size_y

    shape_area = shape_qty.each_with_index.sum do |qty, idx|
      shape_areas[idx] * shape_qty[idx]
    end

    shape_area <= total_area
  }
  .tap { puts _1 }

# Another cheeky solution - check if there is 9 spaces for each shape
regions
  .count { |(size_x, size_y), shape_qty|
    total_spaces = size_x * size_y / 9

    shape_spaces = shape_qty.sum
    shape_spaces <= total_spaces
  }
  .tap { puts _1 }

# TODO - Proper solution for the sample input
