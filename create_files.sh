#!/bin/bash

DIR=$(dirname $(readlink -f $0))

for y in `seq -w 2015 2024`; do
  mkdir $DIR/$y

  for i in `seq -w 1 25`; do
    mkdir $DIR/$y/day-$i

    if [ -z "$(ls -A $DIR/$y/day-$i)" ]; then
      cp template.rb $DIR/$y/day-$i/day-$i-part-1.rb

      if [ $i -ne '25' ]
      then
        cp template.rb $DIR/$y/day-$i/day-$i-part-2.rb
      fi
      sed -i "s/\\$/${i}/g" $DIR/$y/day-$i/*.rb

      touch $DIR/$y/day-$i/README.txt
      touch $DIR/$y/day-$i/day-$i-input.txt
      chmod +x $y/day-$i/*.rb
    fi
  done
done
