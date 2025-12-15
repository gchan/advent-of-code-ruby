--- Day 12: Christmas Tree Farm ---

You're almost out of time, but there can't be much left to decorate. Although there are no stairs, elevators, escalators, tunnels, chutes, teleporters, firepoles, or conduits here that would take you deeper into the North Pole base, there is a ventilation duct. You jump in.

After bumping around for a few minutes, you emerge into a large, well-lit cavern full of Christmas trees!

There are a few Elves here frantically decorating before the deadline. They think they'll be able to finish most of the work, but the one thing they're worried about is the presents for all the young Elves that live here at the North Pole. It's an ancient tradition to put the presents under the trees, but the Elves are worried they won't fit.

The presents come in a few standard but very weird shapes. The shapes and the regions into which they need to fit are all measured in standard units. To be aesthetically pleasing, the presents need to be placed into the regions in a way that follows a standardized two-dimensional unit grid; you also can't stack presents.

As always, the Elves have a summary of the situation (your puzzle input) for you. First, it contains a list of the presents' shapes. Second, it contains the size of the region under each tree and a list of the number of presents of each shape that need to fit into that region. For example:

0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2

The first section lists the standard present shapes. For convenience, each shape starts with its index and a colon; then, the shape is displayed visually, where # is part of the shape and . is not.

The second section lists the regions under the trees. Each line starts with the width and length of the region; 12x5 means the region is 12 units wide and 5 units long. The rest of the line describes the presents that need to fit into that region by listing the quantity of each shape of present; 1 0 1 0 3 2 means you need to fit one present with shape index 0, no presents with shape index 1, one present with shape index 2, no presents with shape index 3, three presents with shape index 4, and two presents with shape index 5.

Presents can be rotated and flipped as necessary to make them fit in the available space, but they have to always be placed perfectly on the grid. Shapes can't overlap (that is, the # part from two different presents can't go in the same place on the grid), but they can fit together (that is, the . part in a present's shape's diagram does not block another present from occupying that space on the grid).

The Elves need to know how many of the regions can fit the presents listed. In the above example, there are six unique present shapes and three regions that need checking.

The first region is 4x4:

....
....
....
....

In it, you need to determine whether you could fit two presents that have shape index 4:

###
#..
###

After some experimentation, it turns out that you can fit both presents in this region. Here is one way to do it, using A to represent one present and B to represent the other:

AAA.
ABAB
ABAB
.BBB

The second region, 12x5: 1 0 1 0 2 2, is 12 units wide and 5 units long. In that region, you need to try to fit one present with shape index 0, one present with shape index 2, two presents with shape index 4, and two presents with shape index 5.

It turns out that these presents can all fit in this region. Here is one way to do it, again using different capital letters to represent all the required presents:

....AAAFFE.E
.BBBAAFFFEEE
DDDBAAFFCECE
DBBB....CCC.
DDD.....C.C.

The third region, 12x5: 1 0 1 0 3 2, is the same size as the previous region; the only difference is that this region needs to fit one additional present with shape index 4. Unfortunately, no matter how hard you try, there is no way to fit all of the presents into this region.

So, in this example, 2 regions can fit all of their listed presents.

Consider the regions beneath each tree and the presents the Elves would like to fit into each of them. How many of the regions can fit all of the presents listed?
