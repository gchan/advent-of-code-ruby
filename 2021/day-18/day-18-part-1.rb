#!/usr/bin/env ruby

file_path = File.expand_path("../day-18-input.txt", __FILE__)
input     = File.read(file_path)

SnailNumber = Struct.new(:pair, :level) do
  def increment_level
    self.level += 1
  end

  def left
    pair.first
  end

  def right
    pair.last
  end
end

def explode(numbers)
  numbers.each_with_index do |number, idx|
    next if number.level < 4

    merge = false

    if idx > 0
      left_num = numbers[idx - 1]

      if left_num.pair.size == 2
        left_num.pair[1] += number.left
      else
        left_num.pair[0] += number.left
      end

      if number.level - 1 == left_num.level && left_num.pair.count == 1
        left_num.pair << 0
        merge = true
      end
    end

    if idx < numbers.size - 1
      right_num = numbers[idx + 1]
      right_num.pair[0] += number.right

      if !merge && number.level - 1 == right_num.level && right_num.pair.count == 1
        right_num.pair.unshift(0)
        merge = true
      end
    end

    if merge
      numbers.delete_at(idx)
    else
      number.pair = [0]
      number.level -= 1
    end

    return true
  end

  false
end

def split(numbers)
  numbers.each_with_index do |number, idx|
    next if number.pair.all? { |el| el < 10 }

    if number.pair.count == 1
      number.pair = [number.left / 2, (number.left / 2.0).ceil]
      number.level += 1
    else
      if number.left > 9
        el = number.pair.shift

        pair = [el / 2, (el / 2.0).ceil]
        numbers.insert(idx, SnailNumber.new(pair, number.level + 1))
      else
        el = number.pair.pop

        pair = [el / 2, (el / 2.0).ceil]
        numbers.insert(idx + 1, SnailNumber.new(pair, number.level + 1))
      end
    end

    return true
  end

  false
end

# Create a flat array of SnailNumbers.
# 'level' attributes denotes the amount of nesting
#
def create_numbers(string)
  # eval is lazy and potentially dangerous
  queue = [[eval(string) , 0]]

  nums = []

  while queue.any?
    node, level = queue.shift

    if node.is_a?(Integer)
      nums << SnailNumber.new([node], level - 1)
    elsif node.all? { |node| node.is_a? Integer }
      nums << SnailNumber.new(node, level)
    else
      node.reverse_each do |child_node|
        queue.unshift([child_node, level + 1])
      end
    end
  end

  nums
end

numbers = []

input.lines.each do |string|
  num = create_numbers(string)

  num.each(&:increment_level) unless numbers.empty?

  numbers.each(&:increment_level)
  numbers.concat(num)

  while explode(numbers); end

  # Keep checking for explodes after a split
  # Stop checking after no more splits
  while split(numbers)
    while explode(numbers); end
  end
end

while numbers.count > 1
  numbers.each do |num|
    next if num.pair.count == 1

    num.pair = [num.left * 3 + num.right * 2]
    num.level -= 1
  end

  numbers.each_cons(2).with_index do |(num1, num2), idx|
    next if num1.level != num2.level

    num1.pair = [num1.left * 3 + num2.left * 2]
    num1.level -= 1
    numbers.delete_at(idx +1)
    break
  end
end

puts numbers.first.left
