#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

DIRS = {
  n: [0, -1],
  s: [0, 1],
  w: [-1, 0],
  e: [1, 0]
}

RIGHT = {
  n: :e,
  s: :w,
  e: :s,
  w: :n
}

LEFT = {
  n: :w,
  s: :e,
  e: :n,
  w: :s
}

# Reference PriorityQueue implementation is sourced from ChatGPT
#
# RubyGem options include `algorithms` or `priority_queue_cxx`
#
# This is a min binary heap (elements with the lowest priority
# are ordered first).
#
# https://en.wikipedia.org/wiki/Binary_heap
#
class PriorityQueue
  def initialize
    @heap = []
  end

  def any?
    @heap.any?
  end

  def enqueue(element, priority)
    @heap << { element: element, priority: priority }
    heapify_up
  end

  def dequeue
    return nil if @heap.empty?

    swap(0, @heap.length - 1)
    max = @heap.pop
    heapify_down
    max[:element]
  end

  private

  def heapify_up
    index = @heap.length - 1

    while index > 0
      parent_index = (index - 1) / 2
      break if @heap[parent_index][:priority] <= @heap[index][:priority]

      swap(parent_index, index)
      index = parent_index
    end
  end

  def heapify_down
    index = 0

    while true
      child_l_index = 2 * index + 1
      child_r_index = 2 * index + 2
      break if child_l_index >= @heap.length

      swap_index =
        if child_r_index >= @heap.length ||
          @heap[child_l_index][:priority] <= @heap[child_r_index][:priority]
          child_l_index
        else
          child_r_index
        end

      break if @heap[index][:priority] <= @heap[swap_index][:priority]

      swap(index, swap_index)
      index = swap_index
    end
  end

  def swap(i, j)
    @heap[i], @heap[j] = @heap[j], @heap[i]
  end
end

grid = input.each_line.map { _1.strip.chars.map(&:to_i) }

def solve(grid:, min_steps: 1, max_steps: 3)
  h = grid.count
  w = grid.first.count

  queue = PriorityQueue.new

  # cost, x, y, direction, steps in direction, priority/cost
  queue.enqueue([0, 0, 0, :e, 0], 0)
  queue.enqueue([0, 0, 0, :s, 0], 0)

  require 'set'
  visited = Set.new

  while queue.any?
    hl, x, y, dir, steps = queue.dequeue

    ops = []
    ops << RIGHT[dir] if steps >= min_steps
    ops << LEFT[dir]  if steps >= min_steps
    ops << dir        if steps < max_steps

    ops.each do |n_dir|
      nx, ny = DIRS[n_dir].zip([x,y]).map(&:sum)

      next if nx < 0 || ny < 0 || nx >= w || ny >= h

      nsteps = n_dir != dir ? 1 : steps + 1
      nhl = grid[ny][nx] + hl

      if nx == (w - 1) && ny == (h - 1) && nsteps >= min_steps
        return nhl
      end

      state = [nhl, nx, ny, n_dir, nsteps]

      next if visited.include?(state.last(4))
      visited << state.last(4)

      queue.enqueue(state, nhl)
    end
  end
end

# Part 1
solve(grid: grid)
  .tap { puts _1 }

# Part 2
solve(grid: grid, min_steps: 4, max_steps: 10)
  .tap { puts _1 }
