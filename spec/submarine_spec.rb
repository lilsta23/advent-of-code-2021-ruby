require 'spec_helper'
require 'submarine'
require 'submarine/depth'

RSpec.describe Submarine do
  let (:submarine) {
    Submarine.new
  }

  let (:example_binary_report) {
    ["00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]
  }

  describe '.total_depth_increases' do
    context "compare adjacent depths" do
      it "returns 0 where there is a single depth (no comparison can occur)" do
        depths = [1]
        expect(submarine.total_depth_increases(depths, Depth.compare_adjacent_depths)).to eql(0)
      end
      it "returns 1 where there is a single increase (base case)" do
        depths = [1, 2]
        expect(submarine.total_depth_increases(depths, Depth.compare_adjacent_depths)).to eql(1)
      end
      it "returns t - y (n) where there are t depths and y non-increases" do
        depths = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
        expect(submarine.total_depth_increases(depths, Depth.compare_adjacent_depths)).to eql(7)
      end
    end

    context "compare adjacent sliding window" do
      it "returns 0 when there is less than two adjacent sliding windows (< 4 depths)" do
        depths = [1, 2, 3]
        expect(submarine.total_depth_increases(depths, Depth.compare_adjacent_sliding_window)).to eql(0)
      end
      it "returns 1 when there is a single increase (s2 > s1)" do
        depths = [1, 2, 3, 4]
        expect(submarine.total_depth_increases(depths, Depth.compare_adjacent_sliding_window)).to eql(1)
      end
      it "returns t - y (n) where there are t depths and y non-increases" do
        depths = [607, 618, 618, 617, 647, 716, 769, 792]
        expect(submarine.total_depth_increases(depths, Depth.compare_adjacent_sliding_window)).to eql(5)
      end
    end
  end

  describe ".initialize" do
    it "is initially at horz=0, depth=0" do
      sub = Submarine.new
      expect(sub.horz).to eql(0)
      expect(sub.depth).to eql(0)
      expect(sub.aim).to eql(0)
    end
  end

  describe ".go_forward" do
    it "goes forward by x" do
      sub = Submarine.new
      sub.aim = 20
      n = 5
      sub.go_forward(n)
      expect(sub.horz).to eql(n)
      expect(sub.depth).to eql(sub.aim * n)
    end
  end

  describe ".go_up" do
    it "goes up by n, expect aim to decrease by n" do
      sub = Submarine.new
      n = 5
      sub.go_up(n)
      expect(sub.aim).to eql(-n)
    end
  end

  describe ".go_down" do
    it "goes down by n, expect aim to increase by n" do
      sub = Submarine.new
      n = 5
      sub.go_down(n)
      expect(sub.aim).to eql(n)
    end
  end

  describe ".get_power_consumption" do
    it "calculates a power consumption of 0 for an empty list" do
      bin_list = []
      result = submarine.get_power_consumption(bin_list, 0)
      expect(result).to eq(0)
    end

    it "calculates the power consumption correctly for a single binary number" do
      # expect 1001 * 0110 = 9 *6
      bin_list =["1001"]
      result = submarine.get_power_consumption(bin_list, bin_list[0].length)
      expect(result).to eq(54)
    end

    it "calculates the power consumption correctly for many binary numbers" do
      result = submarine.get_power_consumption(example_binary_report, example_binary_report[0].length)
      expect(result).to eq(198)
    end
  end

  describe ".get_life_support_rating" do
    it "calculates the life support rating correctly" do
      result = submarine.get_life_support_rating(example_binary_report)
      expect(result).to eq(230)
    end
  end
end
