#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
password  = File.read(file_path)

def increasing_straight?(string)
  string.chars.each_cons(3).any? do |a, b, c|
    a.ord + 1 == b.ord && a.ord + 2 == c.ord
  end
end

def two_pairs?(string)
  string.scan(/(.)\1/).count >= 2
end

def valid_password?(string)
  increasing_straight?(string) &&
    two_pairs?(string)
end

def increment_password(characters, index)
  characters[index] = ((characters[index].ord - 96) % 26 + 97).chr
  new_char = characters[index]

  increment_password(characters, index) if %w(i o l).include?(new_char)
  increment_password(characters, index - 1) if new_char == 'a'
end

characters    = password.chars
next_password = 1

while next_password != 0
  increment_password(characters, -1)

  password = characters.join

  next_password -= 1 if valid_password?(password)
end

puts password
