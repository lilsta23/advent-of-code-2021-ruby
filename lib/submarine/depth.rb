module Depth
  # Perform a comparison between two adjacent depths, a[i+1] > a[i] => True
  def self.compare_adjacent_depths
    lambda do |depths, i| i+1 < depths.length && depths[i+1] > depths[i] end
  end

  # Perform a comparison between two adjacent sliding windows, s2 > s1 => True
  def self.compare_adjacent_sliding_window
    lambda do |depths, i|
      # Exit out if we have surpassed the end of the array. No increase has
      # occurred as no comparison could take place.
      return false if i+3 >= depths.length
      # Calculate sliding windows
      s1 = depths[i] + depths[i+1] + depths[i+2]
      s2 = depths[i+1] + depths[i+2] + depths[i+3]
      return s2 > s1
    end
  end
end
