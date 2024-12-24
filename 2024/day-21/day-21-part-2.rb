#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

def generate_paths(pad)
  width = 3
  pad_locs = {}
  paths = {}

  pad.each.with_index {
    next if _1 == " "
    pad_locs[_1] = [_2 % width, _2 / width]
  }

  pad.product(pad).each do |from, to|
    next if from == " " || to == " "

    if from == to
      paths[[from, to]] = ["A"]
      next
    end

    x1, y1 = pad_locs[from]
    x2, y2 = pad_locs[to]

    dx = x2 - x1
    dy = y2 - y1

    press = []

    dx.times { press << ?> }
    dy.times { press << ?v }
    (-dx).times { press << ?< }
    (-dy).times { press << ?^ }

    press = press
      .permutation(press.length)
      .uniq
      .map { _1 << ?A }
      .select { |code|
        x, y = pad_locs[from]

        code.all? do |dir|
          case dir
          when ?^
            y -= 1
          when ?v
            y += 1
          when ?>
            x += 1
          when ?<
            x -= 1
          end

          pad[x + y * width] != " "
        end
      }

    paths[[from, to]] = press.map(&:join)
  end

  paths
end

pad = "789456123 0A".chars
robot = " ^A<v>".chars

r_paths = generate_paths(robot)
p_paths = generate_paths(pad)

def viable_sequences(code, paths)
  code = [?A] + code.chars

  seqs = [ "" ]

  code.each_cons(2) { |from, to|
    seqs = seqs
      .product(paths[[from, to]])
      .map(&:flatten)
      .map(&:join)
  }

  seqs
end

def shortest_len(seq, iter, r_paths, cache)
  return seq.length if iter == 0
  return cache[[seq, iter]] if cache[[seq, iter]]

  seqs = viable_sequences(seq, r_paths)

  min_length = seqs.map { |seq|
    seq.split(/(?<=A)/).sum {
      shortest_len(_1, iter - 1, r_paths, cache)
    }
  }.min

  cache[[seq, iter]] = min_length

  min_length
end

cache = {}

input.split
  .sum { |code|
    seqs = viable_sequences(code, p_paths)

    min_length = seqs.map { |seq|
      seq.split(/(?<=A)/).sum {
        shortest_len(_1, 25, r_paths, cache)
      }
    }.min

    min = min_length
    num = code.scan(/\d+/).first.to_i

    # Debugging
    #
    # puts code
    # p [min, num, min * num]
    # puts

    min * num
  }
  .tap { puts _1 }
