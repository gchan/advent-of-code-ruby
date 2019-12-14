#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

# output_chemical => [inputs, output_qty]
produce = {}

input.split("\n").each do |reaction|
  inputs, out = reaction.split("=>").map(&:strip)

  # chem => qty
  inputs = Hash[
    *inputs.split(",")
      .map { |from| from.strip.split(" ").reverse }
      .flatten
  ]

  inputs.transform_values! { |qty| qty.to_i }

  out_qty, out_chem = out.split(" ")

  produce[out_chem] = [inputs, out_qty.to_i]
end

required = Hash.new(0)
required["FUEL"] = 1

while required.any? { |chem, qty| chem != "ORE" && qty > 0 }
  required.entries.each do |chem, qty_required|
    next if chem == "ORE"

    inputs, to_qty = produce[chem]

    multiples = (qty_required.to_f / to_qty).ceil

    inputs.each do |in_chem, in_qty|
      required[in_chem] += in_qty.to_i * multiples
    end

    required[chem] -= multiples * to_qty
  end

  required.each do |chem, qty|
    required.delete(chem) if qty == 0
  end
end

puts required["ORE"]
