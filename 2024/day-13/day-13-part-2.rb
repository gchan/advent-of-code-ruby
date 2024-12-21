#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

machines = input.split("\n\n")

machines
  .map { |machine|
    ax, ay, bx, by, px, py = machine.scan(/\d+/).map(&:to_i)

    px += 10000000000000
    py += 10000000000000

    sa = 0
    sb = 0

    # ax * sa + bx * sb = px
    # ay * sa + by * sb = py
    #
    # sb = ( px - ax * sa ) / bx
    #
    # ay * sa = py - by * sb
    #         = py - by * (( px - ax * sa ) / bx)
    #         = py - ( by * px - by * ax * sa ) / bx
    #
    # ay * sa * bx = py * bx - ( by * px - by * ax * sa )
    #              = py * bx - by * px + by * ax * sa
    #
    # ay * sa * bx - by * ax * sa = py * bx - by * px
    # sa ( ay * bx - by * ax ) = ( py * bx - by * px )
    # sa = ( py * bx - by * px ) / ( ay * bx - by * ax )
    #

    sa = ( py * bx - by * px ) / ( ay * bx - by * ax ).to_f
    sb = ( px - ax * sa ) / bx

    if sa.to_i == sa
      sa * 3 + sb
    else
      0
    end
  }
  .sum.to_i
  .tap { puts _1 }
