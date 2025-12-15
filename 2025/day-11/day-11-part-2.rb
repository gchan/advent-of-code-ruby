#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

devices = input
  .split("\n")
  .map {
    src, *dest = _1.split(/: | /)

   [src, dest]
  }
  .to_h

def dfs(devices:, input:, memo: {}, dac: false, fft: false)
  if input == "out"
    return 1 if dac && fft
    return 0
  end

  devices[input].sum do |output|
    key = [output, dac, fft]

    memo[key] ||= dfs(
      devices:,
      input: output,
      memo:,
      dac: dac || output == "dac",
      fft: fft || output == "fft"
    )
  end
end

puts dfs(devices:, input: "svr")
