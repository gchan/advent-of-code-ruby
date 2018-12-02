#!/bin/bash

DIR=$(dirname $(readlink -f $0))

for y in `seq -w 2015 2018`; do
  mkdir $DIR/$y

  for i in `seq -w 1 25`; do
    mkdir $DIR/$y/day-$i
    touch $DIR/$y/day-$i/README.txt
    touch $DIR/$y/day-$i/day-$i-part-1.rb
    if [ $i -ne '25' ]
    then
      touch $DIR/$y/day-$i/day-$i-part-2.rb
    fi
    touch $DIR/$y/day-$i/day-$i-input.txt
    chmod +x $y/day-$i/*.rb
  done
done
