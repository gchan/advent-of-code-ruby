#!/bin/bash

for i in `seq -w 1 25`; do
  mkdir day-$i
  touch day-$i/README.md
  touch day-$i/day-$i-part-1.rb
  touch day-$i/day-$i-part-2.rb
  touch day-$i/day-$i-input.txt
  chmod +x day-$i/*.rb
done
