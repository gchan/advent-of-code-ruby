#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

class Node
  attr_accessor :children, :label, :weight, :parent

  def initialize(label, weight)
    @label = label
    @weight = weight
    @children = []
  end

  def child_weights
    children.each_with_object({}) do |child, result|
      result[child.label] = child.total_weight
    end
  end

  def total_weight
    return weight if children.empty?

    children.map(&:total_weight).inject(:+) + weight
  end

  def balanced?
    child_weights.values.uniq.size == 1
  end
end

programs = input.split("\n")

nodes = {}

programs.each do |disc|
  label = disc.split(" ").first
  weight = disc.scan(/\d+/).first.to_i

  nodes[label] = Node.new(label, weight)
end

programs
  .select { |program| program.include?("->") }
  .each { |disc|
    parent_label = disc.split(" ").first
    parent = nodes[parent_label]

    child_labels = disc.split("->").last.gsub!(",", "").split(" ")

    child_labels.each do |child_label|
      child = nodes[child_label]

      parent.children << child
      child.parent = parent
    end
  }

root = nodes[nodes.keys.first]

until root.parent.nil?
  root = root.parent
end

puts root.label

node = root

while true
  child_weights = node.child_weights

  imbalanced_weight = child_weights.values.uniq
    .find { |v| child_weights.values.count(v) == 1 }

  imbalanced_node_label, _ = child_weights.find do |label, weight|
    weight == imbalanced_weight
  end

  imbalanced_node = nodes[imbalanced_node_label]

  if imbalanced_node.balanced?
    diff = child_weights.values.uniq.inject(:-).abs
    puts imbalanced_node.weight - diff
    break
  else
    node = imbalanced_node
  end
end
