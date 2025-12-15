#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

machines = input.split("\n").map { _1.split(/(?<=\]) | (?=\{)/) }
  .map! { |_lights, buttons, joltage|
    joltage = joltage[1...-1].split(",").map(&:to_i)

    buttons = buttons
      .scan(/
        \(             # Opening parenthesis
        (\d+(?:,\d+)*) # One or more digits separated by commas
        \)             # Closing parenthesis
        /x)
      .flatten
      .map { _1.split(",").map(&:to_i) }

    [joltage, buttons]
  }

@cache = {}
def generate_selections(n, k)
  return @cache[[n, k]] if @cache.key?([n, k])
  result = []

  distribute = ->(i, remaining, counts) do
    if i == n - 1
      counts[i] = remaining
      result << counts
      return
    end

    (0..remaining).each do |count|
      counts[i] = count
      distribute.call(i + 1, remaining - count, counts.dup)
    end
  end

  distribute.call(0, k, Array.new(n, 0))
  result = result.sort!.reverse!
  @cache[[n, k]] = result
  result
end

machines
  .map.with_index { |(joltage, buttons), line|
    # # puts [joltage, buttons].inspect
    puts line

    # Create button mapping (which buttons affect which positions)
    button_map = Array.new(joltage.size) { [] }
    buttons.each_with_index do |button, idx|
      button.each { |pos| button_map[pos] << idx }
    end

    # Sort by button size (largest first) for better pruning
    button_map.map! { |idxs| idxs.sort_by { |i| -buttons[i].size } }


    queue = [[joltage.clone, 0, Array.new(buttons.size, 0)]]
    visited = Hash.new(Float::INFINITY)  # state -> min_presses to reach that state
    count = nil
    max_button_size = buttons.map(&:size).max

    while queue.any?
      state, presses, skip_buttons = queue.shift

      # Skip if we've reached this state with fewer presses before
      next if visited[state] <= presses
      visited[state] = presses

       puts "----------------------------------------"
       puts "line #{line}:"
       puts "Queue size: #{queue.size}"
       puts "Current state: #{state.inspect}"
       puts "Buttons: #{buttons.inspect}"
       puts "skip_buttons: #{skip_buttons.inspect}"
       puts "skip_buttons: #{skip_buttons.map.with_index { buttons[_2] if _1 == 1 }.compact.inspect}"

      # puts button_map.inspect
      button_to_press = button_map.each.with_index.min_by { |idxs, (btn)|
        available_idxs = idxs.reject { |idx| skip_buttons[idx] == 1 }

        size = available_idxs.size.zero? ? Float::INFINITY : available_idxs.size

        #size
        [size, -state[btn]]
      }.last

      # puts "Button to press: #{button_to_press}"
      potential_buttons = button_map[button_to_press]
        .reject { |idx| skip_buttons[idx] != 0 }
        .sort_by { -buttons[_1].size }

      next if potential_buttons.empty?

      puts "Number of potential buttons: #{potential_buttons.size}"

      puts "Presses so far: #{presses}"
      required_presses = state[button_to_press]
      puts "Required presses: #{required_presses}"

      # Prune if this path would exceed current best solution
      next if count && presses + required_presses >= count

      selections = generate_selections(potential_buttons.size, required_presses)

      selections.each do |selection|
        # Early exit if we've found a solution that's as good as this path
        break if count && presses + required_presses >= count

        new_state = state.dup

        selection.each_with_index do |press, idx|
          buttons[potential_buttons[idx]].each { |pos| new_state[pos] -= press }
        end

        next if new_state.any? { _1 < 0 }

        # Calculate lower bound: minimum presses needed to reach solution from new_state
        remaining_sum = new_state.sum
        lower_bound = (remaining_sum.to_f / max_button_size).ceil
        next if count && presses + required_presses + lower_bound >= count

        next if visited[new_state] <= presses + required_presses

        if new_state.all? { _1 == 0 }
          count = [count, presses + required_presses].compact.min
          puts "Found solution with #{count} presses"
          break
        end

        # puts new_state.inspect
        new_skip_buttons = skip_buttons.dup

        potential_buttons.each do |idx|
          new_skip_buttons[idx] = 1
        end

        queue.unshift [new_state, presses + required_presses, new_skip_buttons]
        #queue = [] if count
      end

      #puts state.inspect
      #puts
    end

    # puts

    raise if count.nil?
    count
  }
  .sum
  .tap { puts _1 }
