#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

grid = input.each_line.map { _1.strip.chars }

w = grid.first.count
h = grid.count

idx = grid.flatten.index(?S)

y = idx / h
x = idx % h

# Observations
#
# * We start at the centre of the grid
# * The grid is square and has an odd width and length
# * e.g. 131 x 131 and we start in the middle at index 65, 65
# * There is no rocks in the starting row and column therefore it is possible
# to reach any edge in 65 steps
# * From the centre point of any edge (middle row or column), we can
# walk to the opposite edge in 131 steps
# * The border of the grid has no rocks
# * From the centre, we can reach the corner of any grid in 65 + 65 steps
# * From corner of any grid, we can reach the centre of a connecting edge
# in 65 steps.
# * From the centre, we can reach the furtherest edges of the four adjacent
# grids in 65 + 131 steps (by walking up, down, right, left to the edge in
# 65 steps, then walk from one edge to the opposite edge in 131 steps)
# * From the centre, we can reach furtherest edges of grids (2 grids away) in
# 65 + 131 * 2 steps. For the third furtherest grids, it is 65 + 131 * 3
# * We can draw a diamond in a universe where the grid is duplicated 3 times
# wide and high (3 x 3). From the centre, it takes 65 + 131 steps to reach
# the corner of the diamond, and the furtherest edge of a 3 x 3 universe
# * We can extend the universe by 131 * 2 and grow it into a 5 x 5 grid
# of grids. You can reap the process again and again for a 7x7, 9x9 and so
# on.
# * Observe the growth of our universe is quadratic!
# * The diamond (representing the reachable area) is also quadratic.
#
#        ------
#        | /\ |
#        |/  \|
#       /|    |\
#   ___/_|____|_\___
#   | /  |    |  \ |
#   |/   |    |   \|
#   |\   |    |   /|
#   |_\ _|____|_ /_|
#      \ |    | /
#       \|    |/
#        |\  /|
#        |_\/_|
#
# * The number of steps in our problem is 65 + 131 * 202300 = 26_501_365
# * We can solve the reachable area for the following:
#   - (65 + 131) + 131 * 0 = y0
#   - (65 + 131) + 131 * 1 = y1
#   - (65 + 131) + 131 * 2 = y2
# * And use these points to solve for a, b and c of the quadratic formula:
# y = ax^2 + bx + c where y is the number of reachable points and x is the
# size (as a multiple of 131 + (65 + 131)) of our universe
#
# * Apply a bit of algebra to solve a, b and c
# * y0 = c = a0^2 + b0 + c
# * y1 = a + b + c = a1^2 + 1b + c
# * y2 = a2^2 + 2b + c = 4a + 2b + c
# * a = (y2 + c - 2y1) / 2
# * b = y1 - a - c
#
# * Plug in 26_501_365 / 131 in the forumla to get the answer!

queue = [[x, y, 0]]

visited = {}
visited[[x,y]] = 0

while queue.any?
  x, y, step = queue.shift

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
    x1, y1 = dir.zip([x,y]).map(&:sum)

    y2 = y1 % h
    x2 = x1 % w
    c = grid[y2][x2]

    next if c == ?#
    next if visited[[x1, y1]]
    next if step > w * 3

    visited[[x1,y1]] = step + 1
    queue << [x1, y1, step + 1]
  end
end

y0, y1, y2 = 3.times.map { |i|
  # 65 + 131 * i
  step = w / 2 + w * i

  visited.values
    .count { _1 <= step && _1 % 2 == step % 2 }
}

c = y0
a = (y2 + c - 2 * y1) / 2
b = y1 - a - c

steps = 26_501_365

x = steps / w
y = a * x**2 + b * x + c

pp y
