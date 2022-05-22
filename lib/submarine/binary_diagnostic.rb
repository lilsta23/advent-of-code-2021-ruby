module BinaryDiagnostic
  def invert_binary_number(binary_str)
    binary_str.chars.reduce(""){|str, digit| str += (digit == "0" ? "1" : "0")}.to_i(2)
  end

  def get_most_common_binary_number_as_str(binary_strings, bin_size)
    # Init binary total counter array to 0. It will be the same length as the
    # binary numbers.
    bin_total = Array.new(bin_size){|_| 0}

    # Assumption: array of strings
    # Iterate through each binary number and 'record' the value of each digit
    # on the 'bin_total' counter
    binary_strings.each do |bin_str|
      # Handle exception of binary string mismatch
      if bin_str.length != bin_size
        raise "Binary string is incorrect length '#{bin_str.length}', expected '#{bin_size}'"
      end

      # Increase/decrease 'total' for digit depending on value.
      (0...bin_str.length).each do |i|
        bin_total[i]+=(if bin_str[i] == "1" then 1 else -1 end)
      end
    end

    bin_str = []

    # digit > 0 if more 1s than 0s for that digit position.
    (0...bin_size).each{|i| if bin_total[i] > 0 then bin_str << "1" else bin_str << "0" end}
    # return transformed array as an integer, reflecting the most common bit in each
    # digit position.
    return bin_str.join
  end

  def find_common_bit(bit_criteria, binary_strings, position)
    # calculate total bits at position x
    total = 0
    binary_strings.each{|bin| total+=(bin[position].to_i == 1 ? 1 : -1)}

    # if all bits are the same, make filter null.
    if total == -binary_strings.length || total == binary_strings.length
      return nil
    end
    # depending on the bit criteria return the most/least common bit.
    case bit_criteria
    when :oxygen_rating
      # most common bit
      return (total >= 0 ? 1 : 0)
    when :co2_rating
      # least common bit
      return (total >= 0 ? 0 : 1)
    end
  end

  def filter_by_common_bit(bit_criteria, binary_strings, position)
    # Return out if list DOES NOT need filtering
    return binary_strings if binary_strings.length == 1

    common_bit = find_common_bit(bit_criteria, binary_strings, position)
    # return out if all bits are the same for this particular position (we can't filter all numbers out)
    return binary_strings if common_bit == nil

    return binary_strings.filter{|bin| bin[position].to_i == common_bit}
  end

  def get_oxygen_and_co2_rating(oxygen_binary_strings, co2_binary_strings, position = 0)
    # Recurse through oxygen/co2 lists, filter until we have a final oxygen
    # and co2 rating (returns the tuple.)

    # Base case - oxygen and co2 lists have 1 string each (i.e. we have found
    # both oxygen and co2 rating)
    if oxygen_binary_strings.length <= 1 && co2_binary_strings.length <= 1
      # return a tuple of the oxygen and co2 rating
      return [oxygen_binary_strings[0], co2_binary_strings[0]]
    end

    # General case - oxy.length > 1 || co2.length > 1 (i.e. we need to KEEP
    # filtering)
    oxygen_binary_strings = filter_by_common_bit(:oxygen_rating, oxygen_binary_strings, position)
    co2_binary_strings = filter_by_common_bit(:co2_rating, co2_binary_strings, position)
    # Recurse again with newly filtered lists
    return get_oxygen_and_co2_rating(oxygen_binary_strings, co2_binary_strings, position+1)
  end
end
