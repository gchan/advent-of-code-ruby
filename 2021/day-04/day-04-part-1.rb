#!/usr/bin/env ruby

require 'set'

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n")

lines_per_board = 6
line_offset = 2
num_boards = lines.count / lines_per_board

boards = num_boards.times.map do |idx|
  idx *= lines_per_board
  idx += line_offset

  lines[idx, lines_per_board - 1].map(&:split).map { |row| row.map(&:to_i) }
end

board_map = Hash.new { |hash, key| hash[key] = Set.new }

boards.each_with_index do |board, idx|
  board.each_with_index do |row, y|
    row.each_with_index do |num, x|
      board_map[num].add([idx, y, x])
    end
  end
end

numbers = lines.first.split(",").map(&:to_i)

numbers.each do |num|
  board_map[num].each do |board_idx, row, col|
    board = boards[board_idx]

    board[row][col] = nil

    if board[row].all?(&:nil?) || board.transpose[col].all?(&:nil?)
      puts board.flatten.compact.sum * num
      exit
    end
  end
end
