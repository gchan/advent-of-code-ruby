#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
password  = File.read(file_path)

def increasing_straight?(password)
  password.chars.each_cons(3).any? do |a, b, c|
    a.ord + 1 == b.ord && a.ord + 2 == c.ord
  end
end

def two_pairs?(password)
  password.scan(/(.)\1/).count >= 2
end

def excludes_confusing_characters(password)
  password.scan(/[iol]/).empty?
end

def valid_password?(password)
  increasing_straight?(password) &&
    two_pairs?(password) &&
    excludes_confusing_characters(password)
end

next_password = 1

while next_password != 0
  password.succ!

  next_password -= 1 if valid_password?(password)
end

puts password
