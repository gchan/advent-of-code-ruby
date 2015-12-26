#!/usr/bin/env ruby

file_path    = File.expand_path("../day-07-input.txt", __FILE__)
instructions = File.readlines(file_path)

class Circuit
  attr_reader :output_wire, :input_wires, :values, :gate

  def initialize(instruction)
    @gate        = instruction.match(/[A-Z]+/).to_a[0]
    @output_wire = instruction.match(/-> (.+)/)[1]

    inputs = instruction.scan(/([a-z0-9]+) /).flatten

    @input_wires = inputs.select { |input| input.match /[a-z]+/ }
    @values = inputs.reject { |input| input.match /[a-z]+/ }.map(&:to_i)
  end

  # Replace the wire with the known value
  def simplify(wire, value)
    values.unshift(value) if input_wires.delete(wire)
  end

  # The value of the output wire is known if there are no more input wires
  def output
    return nil if input_wires.any?

    case gate
    when "AND"
      values[0] & values[1]
    when "OR"
      values[0] | values[1]
    when "NOT"
      ~values[0]
    when "LSHIFT"
      values[0] << values[1]
    when "RSHIFT"
      values[0] >> values[1]
    else
      values[0]
    end
  end
end

# Circuits organised by input wires
circuits  = Hash.new { |hash, input| hash[input] = [] }
outputs = {}
target_wire = "a"

instructions.each do |instruction|
  circuit = Circuit.new(instruction)

  circuit.input_wires.each do |input|
    circuits[input] << circuit
  end

  outputs[circuit.output_wire] = circuit.output if circuit.output
end


while !outputs[target_wire]
  evaluated = {}

  outputs.each do |wire, wire_value|
    circuits[wire].each do |circuit|
      circuit.simplify(wire, wire_value)

      if circuit.output
        evaluated[circuit.output_wire] = circuit.output
      end
    end

    outputs.delete(wire)
  end

  outputs.merge!(evaluated)
end

puts outputs[target_wire]
