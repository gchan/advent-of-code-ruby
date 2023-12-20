#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input     = File.read(file_path)

modules = {}

input.each_line.each do
  name, output = _1.split("->").map(&:strip)
  output = output.split(",").map(&:strip)

  if name != "broadcaster"
    type = name[0]
    name = name[1..]
  end

  case type
  when ?%
    memory = false
  when ?&
    memory = {}
  end

  modules[name] = [type, memory, output]
end

modules.each do |n, (_type, _memory, out)|
  out.each do |n1|
    type1, memory1, _ = modules[n1]

    memory1[n] = :l if type1 == ?&
  end
end

queue = []
cycles = {}

100_000.times do |i|
  modules["broadcaster"].last.each do |to|
    queue << ["broadcaster", to, :l]
  end

  while queue.any?
    from, to, sig = queue.shift

    type, memory, out = modules[to]

    # My input had these four modules connected to lx which was the
    # conjunction module for rx.
    #
    # For lx to fire to a low pulse to rx, all 4 modules must
    # send a low pulse to lx. Identify the cycle when each module
    # sends a low pulse and find the lcm of these 4 numbers.
    #
    if %w(cl rp lb nj).include?(to) && sig == :l
      cycles[to] = i + 1

      if cycles.size == 4
        pp cycles.values.inject(:lcm)
        exit
      end
    end

    next if type.nil?

    case type
    when ?%
      next if sig == :h

      out_sig = memory ? :l : :h

      modules[to][1] = !memory
    when ?&
      memory[from] = sig

      if memory.values.all? { _1 == :h }
        out_sig = :l
      else
        out_sig = :h
      end
    end

    out.each do
      queue << [to, _1, out_sig]
    end
  end
end
