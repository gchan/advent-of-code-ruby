#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

monkeys = input.split(?\n).map {
  out, ins = _1.split(": ")
  ins = ins.to_i if ins.match?(/\d+/)

  [out, ins]
}

solved, unsolved = monkeys
  .partition { _2.is_a?(Numeric) }
  .map(&:to_h)

human_str = "humn"

ancestry = []

search = human_str
target_str = nil

while search
  key, expression = unsolved.find { _2.include?(search) }

  if key == "root"
    target_str = expression.split
      .select { _1.match?(/\w/) }
      .find { _1 != ancestry.last[0] }

    search = nil
  else
    ancestry << [key, expression]
    search = key
  end
end

while unsolved.any?
  unsolved.each do |out, expression|
    a, op, b = expression.split
    next unless solved[a] && solved[b]

    solved[out] = solved[a].send(op, solved[b])
    unsolved.delete(out)
  end
end

target = solved[target_str]

ancestry.reverse!.each.with_index do |(key, expression), idx|
  a, op, b = expression.split

  next_str = ancestry[idx + 1]&.first || human_str

  # Debugging
  #if b == next_str
  #  expression.sub!(a, solved[a].to_s)
  #else
  #  expression.sub!(b, solved[b].to_s)
  #end

  #puts "#{target} = #{expression}"

  case op
  when ?-
    if b == next_str
      target = -target + solved[a]
    else
      target = target + solved[b]
    end
  when ?+
    if b == next_str
      target = target - solved[a]
    else
      target = target - solved[b]
    end
  when ?/
    if b == next_str
      target = 1/target * solved[a]
    else
      target = target * solved[b]
    end
  when ?*
    if b == next_str
      target = target / solved[a]
    else
      target = target / solved[b]
    end
  end
end

puts target
