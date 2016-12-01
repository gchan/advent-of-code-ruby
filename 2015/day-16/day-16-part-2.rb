#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
sues      = File.readlines(file_path)

sues.map! do |sue|
  {
    number:      sue.scan(/Sue (\d+)/).flatten.map(&:to_i).first,
    children:    sue.scan(/children: (\d+)/).flatten.map(&:to_i).first,
    cats:        sue.scan(/cats: (\d+)/).flatten.map(&:to_i).first,
    samoyeds:    sue.scan(/samoyeds: (\d+)/).flatten.map(&:to_i).first,
    pomeranians: sue.scan(/pomeranians: (\d+)/).flatten.map(&:to_i).first,
    akitas:      sue.scan(/akitas: (\d+)/).flatten.map(&:to_i).first,
    vizslas:     sue.scan(/vizslas: (\d+)/).flatten.map(&:to_i).first,
    goldfish:    sue.scan(/goldfish: (\d+)/).flatten.map(&:to_i).first,
    trees:       sue.scan(/trees: (\d+)/).flatten.map(&:to_i).first,
    cars:        sue.scan(/cars: (\d+)/).flatten.map(&:to_i).first,
    perfumes:    sue.scan(/perfumes: (\d+)/).flatten.map(&:to_i).first
  }
end

compounds = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

real_sue = sues.find do |sue|
  compounds.all? do |compound, value|
    sue[compound].nil? ||
      case compound
      when :cats
        sue[compound] > value
      when :trees
        sue[compound] > value
      when :pomeranians
        sue[compound] < value
      when :goldfish
        sue[compound] < value
      else
        sue[compound] == value
      end
  end
end

puts real_sue[:number]
