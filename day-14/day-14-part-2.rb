#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
reindeers = File.readlines(file_path)

seconds = 2503

# OO overboard!
class Reindeer
  attr_reader :speed, :duration, :rest, :distance, :points

  def initialize(speed, duration, rest)
    @speed    = speed
    @duration = duration
    @rest     = rest

    @distance     = 0
    @points       = 0
    @resting_time = 0
    @flying_time  = 0
  end

  def tick
    if resting?
      rest_tick
    else
      fly_tick
    end

    begin_rest if time_to_rest?
  end

  def award_point
    @points += 1
  end

  private

  def rest_tick
    @resting_time -= 1
  end

  def fly_tick
    @flying_time += 1
    @distance += speed
  end

  def time_to_rest?
    @flying_time == duration
  end

  def resting?
    @resting_time > 0
  end

  def begin_rest
    @flying_time = 0
    @resting_time = rest
  end
end

reindeers.map! do |reindeer|
  speed    = reindeer.match(/(\d+) km\/s/)[1].to_i
  duration = reindeer.match(/(\d+) seconds,/)[1].to_i
  rest     = reindeer.match(/(\d+) seconds\./)[1].to_i

  Reindeer.new(speed, duration, rest)
end

seconds.times do
  reindeers.each { |r| r.tick }
  max_distance = reindeers.map { |r| r.distance }.max
  reindeers.select { |r| r.distance == max_distance }.each(&:award_point)
end

puts reindeers.map(&:points).max
