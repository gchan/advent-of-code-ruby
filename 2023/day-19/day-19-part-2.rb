#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

fns, parts = input.split("\n\n")

parts = parts.each_line.map { eval _1.strip.gsub(?=, ?:) }
ins = fns.each_line.map { _1.strip }

fns = {}

ins.each {
  fn, method = _1.split(?{)

  # [[cond, method], ... [method]]
  fns[fn] = method
    .gsub(?}, '')
    .split(?,)
    .map { |exp| exp.split(?:).compact }
}

# Part 1
#
sum = 0

parts.each do |part|
  f = "in"

  while f
    if f == "R"
      break
    end

    if f == "A"
      sum += part.values.sum
      break
    end

    fn = fns[f]

    fn.each do |exp|
      if exp.count == 2
        iff = exp[0]
        nf = exp[1]

        sym = iff[0].to_sym
        op = iff[1]
        val = iff[2..-1].to_i

        if part[sym].send(op, val)
          f = nf
          break
        end
      else
        f = exp.first
      end
    end
  end
end

pp sum


# Part 2
#
queue = [
  ["in", {x: 1..4000, m: 1..4000, a: 1..4000, s: 1..4000 }]
]

sum = 0

while queue.any?
  f, part = queue.pop

  next if f == "R"

  if f == "A"
    sum += part.values.map(&:size).inject(&:*)
    next
  end

  fns[f].each do |exp|
    if exp.count == 1
      queue << [exp.first, part]
      next
    end

    iff = exp[0]
    nf = exp[1]

    sym = iff[0].to_sym
    op = iff[1]
    val = iff[2..-1].to_i

    r = part[sym]

    if op == ?>
      if r.end > val
        ro = part.clone
        ro[sym] = (val+1)..r.end
        queue << [nf, ro]
      end

      if r.begin <= val
        part[sym] = r.begin..val
      end
    else # <
      if r.begin < val
        lo = part.clone
        lo[sym] = r.begin..(val - 1)
        queue << [nf, lo]
      end

      if val <= r.end
        part[sym] = val..r.end
      end
    end
  end
end

pp sum
