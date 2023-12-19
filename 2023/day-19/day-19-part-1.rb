#!/usr/bin/env ruby

file_path = File.expand_path("../day-19-input.txt", __FILE__)
input     = File.read(file_path)

fns, parts = input.split("\n\n")

parts = parts.each_line.map { eval _1.strip.gsub(?=, ?:) }
fns = fns.each_line.map { _1.strip }

# Define the Ruby methods :D
# See part 2 for a less meta solution
#
# Example fn
# hjp{a>2545:nb,a>2381:qx,m>2463:nn,bt}

fns.each {
  r = _1
    .gsub(/\A/, "def ")                 # start of method
    .gsub(?:, ";")                      # end of if boolean exp
    .gsub(?{, "(o); if o[:")            # end of method def and start of body
    .gsub(?<, "]<")                     # close array accesor
    .gsub(?>, "]>")                     # close array accessor
    .gsub(?}, "(o); end; end")          # end of if brand and end of method
    .gsub(?,, "(o); elsif o[:")         # next if branch (elsif)
    .gsub(":pp", ":ppp")                # avoid redefining `pp` method
    .gsub("def pp(", "def ppp(")        # avoid redefining `pp` method
    .gsub("R(o)", "")                   # ignore calls to R
    .gsub("A(o)", "o.values.sum")       # the answer :)

  r[r.rindex("elsif"), 9] = "else "     # last branch should just be 'else'

  eval r
}

parts
  .map { send(:in, _1) }
  .compact
  .sum
  .tap { puts _1 }
