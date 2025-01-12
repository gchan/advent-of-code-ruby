#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input = File.read(file_path)

map, instructions = input.split("\n\n")

instructions = instructions.scan(/\d+|[A-z]+/)

rows = map.split("\n")
width = rows.map(&:size).max
height = rows.size

grid = rows
  .map { _1.ljust(width, " ") }
  .map(&:chars)

# Dice map with relative rotations
#
# Face 1 has the same orientation as its neighbours, no rotation required
# Face 5 relative to face 4 requires a quarter anti-clockwise turn rotation
# Face 4 relative to face 5 requires a quarter clockwise turn
#
# So when heading north of face 5, it 'portals' to the right edge of face 4
# and is facing west (turn left)
#
#    4^         4>         4<
# 2^ 1^ 5^   1^ 5^ 6v   6v 2^ 1^
#    3^         3<         3>
#
#    6^         1^         3^
# 2> 4^ 5<   2< 3^ 5>   2v 6^ 5v
#    1^         6^         4^

FACE_MAP = {
  [1, ?N] => [4, ?N], [5, ?N] => [4, ?E], [2, ?N] => [4, ?W],
  [1, ?E] => [5, ?N], [5, ?E] => [6, ?S], [2, ?E] => [1, ?N],
  [1, ?W] => [2, ?N], [5, ?W] => [1, ?N], [2, ?W] => [6, ?S],
  [1, ?S] => [3, ?N], [5, ?S] => [3, ?W], [2, ?S] => [3, ?E],

  [4, ?N] => [6, ?N], [3, ?N] => [1, ?N], [6, ?N] => [3, ?N],
  [4, ?E] => [5, ?W], [3, ?E] => [5, ?E], [6, ?E] => [5, ?S],
  [4, ?W] => [2, ?E], [3, ?W] => [2, ?W], [6, ?W] => [2, ?S],
  [4, ?S] => [1, ?N], [3, ?S] => [6, ?N], [6, ?S] => [4, ?N],
}

DIRS = [?N, ?E, ?S, ?W]

# Assign face numbers to the input and orient them so they are 'facing upwards'
# with a BFS starting with the top left-most face as number 1

face_size = Math.sqrt(grid.flatten.join.gsub(" ", "").size / 6).to_i

fw = width / face_size
fh = height / face_size

y = 0
x = grid.first.index(".")

faces = {}
face_locs = {}

faces[1] = face_size.times.map { |yd| grid[y + yd][x, face_size] }
face_locs[1] = [x, y, ?N]

queue = [[x, y, 1, ?N]]
visited = Set.new([[x, y]])

while queue.any?
  x, y, face, f_dir = queue.shift

  [
    [x + face_size, y, ?E],
    [x - face_size, y, ?W],
    [x, y + face_size, ?S],
    [x, y - face_size, ?N]
  ]
    .select { _1 >= 0 && _2 >= 0 && _1 < width && _2 < height }
    .reject { grid[_2][_1] == " " }
    .reject { visited.include?([_1, _2])}
    .each { |x1, y1, move_dir|
      adj_dir =
        case f_dir
        when ?N
          move_dir
        when ?S
          # U-Turn
          DIRS[(DIRS.index(move_dir) + 2) % 4]
        when ?E
          # Left
          DIRS[(DIRS.index(move_dir) - 1) % 4]
        when ?W
          # Right
          DIRS[(DIRS.index(move_dir) + 1) % 4]
        end

      next_face, next_f_dir = FACE_MAP[[face, adj_dir]]

      face_grid = face_size.times.map { |yd| grid[y1 + yd][x1, face_size] }

      # Rotate the face so it's 'facing up'
      # Rotation respects current f_dir
      rotation =
        case f_dir
        when ?N
          next_f_dir
        when ?S
          # U-Turn
          DIRS[(DIRS.index(next_f_dir) + 2) % 4]
        when ?E
          # Right
          DIRS[(DIRS.index(next_f_dir) + 1) % 4]
        when ?W
          # Left
          DIRS[(DIRS.index(next_f_dir) - 1) % 4]
        end

      case rotation
      when ?N
      when ?E
        face_grid = face_grid.transpose.reverse
      when ?W
        face_grid = face_grid.transpose.map(&:reverse)
      when ?S
        2.times {
          face_grid = face_grid.transpose.map(&:reverse)
        }
      end

      faces[next_face] = face_grid
      face_locs[next_face] = [x1, y1, rotation]

      visited.add([x1, y1])
      queue << [x1, y1, next_face, next_f_dir]
    }
end

face = 1
x, y = [0, 0]
dir = [1, 0]

instructions.each do
  case _1
  when "L"
    dir = [dir[1], -dir[0]]
  when "R"
    dir = [-dir[1], dir[0]]
  else # number
    _1.to_i.times {
      x1, y1 = [x, y].zip(dir).map(&:sum)

      next_face, next_rotation = if x1 < 0
        FACE_MAP[[face, ?W]]
      elsif y1 < 0
        FACE_MAP[[face, ?N]]
      elsif x1 >= face_size
        FACE_MAP[[face, ?E]]
      elsif y1 >= face_size
        FACE_MAP[[face, ?S]]
      else
        face
      end

      # Teleport
      if face != next_face
        # N - no change
        # S - 180 (mirror both)
        # E - right  (swap and mirror y)
        # W - left (swap and mirror x)
        case next_rotation
        when ?N
        when ?S
          x1 = (face_size - 1) - x1
          y1 = (face_size - 1) - y1
        when ?E
          x1, y1 = y1, (face_size - 1) - x1
        when ?W
          x1, y1 = (face_size - 1) - y1, x1
        end
      end

      x1 = x1 % face_size
      y1 = y1 % face_size

      break if faces[next_face][y1][x1] == "#"
      #p [x1, y1, next_face]

      # Rotate Direction
      if face != next_face
        # E - Left
        # W - Right
        # S - 180
        # N - no change
        dir = case next_rotation
        when ?N
          dir
        when ?E
          dir = [dir[1], -dir[0]]
        when ?W
          dir = [-dir[1], dir[0]]
        when ?S
          dir = [-dir[0], -dir[1]]
        end

        #p dir
      end


      x, y = x1, y1
      face = next_face
    }
  end
end


# Calculate the cube net's X and Y
# A rotation may be required

x1, y1, rotation = face_locs[face]

# Similar code as the 'teleport' code above
# Except in reverse (E and W are reversed)
# N - no change
# S - 180 (mirror both)
# E - left (swap and mirror x)
# W - right  (swap and mirror y)
case rotation
when ?N
when ?S
  x = (face_size - 1) - x
  y = (face_size - 1) - y
when ?E
  x, y = (face_size - 1) - y, x
when ?W
  x, y = y, (face_size - 1) - x
end

x = x % face_size
y = y % face_size

# Adjust for the face's position on the cube net
x += x1
y += y1

dir = case rotation
  when ?N
    dir
  when ?E
    # Right
    dir = [-dir[1], dir[0]]
  when ?W
    # Left
    dir = [dir[1], -dir[0]]
  when ?S
    # U-Turn
    dir = [-dir[0], -dir[1]]
  end

puts (y + 1) * 1000 +
  (x + 1) * 4 +
  [[1, 0], [0, 1], [-1, 0], [0, -1]].index(dir)
