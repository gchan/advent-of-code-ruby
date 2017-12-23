#!/usr/bin/env ruby

# Count composite (non-prime) numbers from b to c

b = 109900
c = b + 17000

puts (b..c).step(17).count { |b|
  (2..(Math.sqrt(b))).any? { |e| b % e == 0 }
}
