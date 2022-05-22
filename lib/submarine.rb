require 'submarine/binary_diagnostic'

class Submarine
  include BinaryDiagnostic

  attr_accessor :horz, :depth, :aim

  def initialize
    @horz, @depth, @aim = 0, 0, 0
  end

  def total_depth_increases(depths, has_increased_callback)
    # base case: less than 2 depths, no comparison can occur (no increase)
    return 0 if depths.length < 2

    num_increases = 0
    depth_range = 0...depths.length

    depth_range.each{|i| num_increases+=1 if has_increased_callback.call(depths, i)}
    return num_increases
  end

  def get_power_consumption(binary_strings, bin_size)
    gamma_rate_str = get_most_common_binary_number_as_str(binary_strings, bin_size)
    gamma_rate = gamma_rate_str.to_i(2)
    epsilon_rate = invert_binary_number(gamma_rate_str)

    # multiply to get power consumption
    return gamma_rate * epsilon_rate
  end

  def get_life_support_rating(binary_strings)
    oxygen_rating, co2_rating = get_oxygen_and_co2_rating(binary_strings, binary_strings)
    return oxygen_rating.to_i(2) * co2_rating.to_i(2)
  end

  def go_forward(x)
    @horz += x
    @depth += @aim * x
  end

  def go_up(y)
    @aim -= y
  end

  def go_down(y)
    @aim += y
  end

end
