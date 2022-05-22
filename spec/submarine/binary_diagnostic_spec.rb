require 'submarine'
require 'submarine/binary_diagnostic'

RSpec.describe BinaryDiagnostic do
  let(:submarine) {
    Submarine.new
  }
  describe ".find_common_bit" do
    context "oxygen rating" do
      it "finds the most common bit at position x for n binary numbers" do
        bin_nums = ["1110", "1111", "1110"]
        most_common_bit = submarine.find_common_bit(:oxygen_rating, bin_nums, 3)
        expect(most_common_bit).to eq(0)
      end
      it "returns 1 where there are equal 0s and 1s at position x" do
        bin_nums = ["1110", "1111", "0110", "0110"]
        most_common_bit = submarine.find_common_bit(:oxygen_rating, bin_nums, 0)
        expect(most_common_bit).to eq(1)
      end
    end

    context "c02 scrubber rating" do
      it "finds the least common bit at position x for n binary numbers" do
        bin_nums = ["1110", "1111", "1110"]
        least_common_bit = submarine.find_common_bit(:co2_rating, bin_nums, 3)
        expect(least_common_bit).to eq(1)
      end
      it "returns 0 where there are equal 0s and 1s at position x" do
        bin_nums = ["1110", "1111", "0110", "0110"]
        least_common_bit = submarine.find_common_bit(:co2_rating, bin_nums, 0)
        expect(least_common_bit).to eq(0)
      end
    end

  end

  describe ".filter_by_common_bit" do
    it "filters out all binary strings with 1 at position x" do
      bin_nums = ["1110", "1111", "1110"]
      filtered_list = submarine.filter_by_common_bit(:oxygen_rating, bin_nums, 3)
      expect(filtered_list).to eq(["1110", "1110"])
    end
    it "filters out all binary strings with 0 at position x" do
      bin_nums = ["1110", "1111", "0110", "0110"]
      filtered_list = submarine.filter_by_common_bit(:oxygen_rating, bin_nums, 0)
      expect(filtered_list).to eq(["1110", "1111"])
    end

    it "does not perform filter where the value is the same for all binary strings at pos x" do
      bin_nums = ["1110", "1111", "1110", "1110"]
      filtered_list = submarine.filter_by_common_bit(:oxygen_rating, bin_nums, 0)
      expect(filtered_list).to eq(["1110", "1111", "1110", "1110"])
    end
  end

  describe ".get_oxygen_and_co2_rating" do
    it "correctly filters down to 1 binary string for both the oxygen and co2 rating" do
      bin_nums = ["1110", "1111", "0110", "0111"]
      oxygen_rate, co2_rate = submarine.get_oxygen_and_co2_rating(bin_nums, bin_nums.clone)
      expect(oxygen_rate).to eq ("1111")
      expect(co2_rate).to eq("0110")
    end
  end
end
