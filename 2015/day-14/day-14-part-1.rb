#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
reindeers = File.readlines(file_path)

seconds = 2503

class Reindeer
  attr_reader :speed, :duration, :rest, :distance

  def initialize(speed, duration, rest)
    @speed    = speed
    @duration = duration
    @rest     = rest
    @distance = 0
  end

  def race(seconds)
    while seconds > 0
      @distance += speed * [seconds, duration].min
      seconds -= duration
      seconds -= rest
    end

    self
  end
end

reindeers.map! do |reindeer|
  speed            = reindeer.match(/(\d+) km\/s/)[1].to_i
  duration         = reindeer.match(/(\d+) seconds,/)[1].to_i
  resting_duration = reindeer.match(/(\d+) seconds\./)[1].to_i

  Reindeer.new(speed, duration, resting_duration).race(seconds)
end

puts reindeers.map(&:distance).max
