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

hc = 0
lc = 0
queue = []

1000.times do |i|
  lc += 1

  modules["broadcaster"].last.each do |to|
    queue << ["broadcaster", to, :l]
    lc += 1
  end

  while queue.any?
    from, to, sig = queue.shift

    type, memory, out = modules[to]

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

    if out_sig == :l
      lc += out.count
    else
      hc += out.count
    end

    out.each do
      queue << [to, _1, out_sig]
    end
  end
end

pp hc * lc
