task :default => [:calc_life_support]

desc "Read a file of binary numbers and calculate life support"
task "calc_life_support" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'submarine'
  require 'file_parser'

  submarine = Submarine.new
  # move the submarine
  bin_nums = FileParser::BinaryDiagnosticParser.convert_binary_numbers_to_array("day3.txt")
  puts submarine.get_life_support_rating(bin_nums)
end


desc "Read a file of binary numbers and calculate power consumption"
task "calc_power_consumption" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'submarine'
  require 'file_parser'

  submarine = Submarine.new
  # move the submarine
  bin_nums = FileParser::BinaryDiagnosticParser.convert_binary_numbers_to_array("day3.txt")
  puts submarine.get_power_consumption(bin_nums, bin_nums[0].length)
end


desc "Read a file of movement instructions and move the submarine accordingly"
task "execute_submarine_movements" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'submarine'
  require 'file_parser'

  submarine = Submarine.new
  # move the submarine
  FileParser::DirectionParser.perform_submarine_movements("day2.txt", submarine)
  # output the final value
  puts submarine.horz*submarine.depth
end

desc "Read a file of depth values and calculate how many times the depth increased"
task "depth_calculation_adjacent" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'submarine'
  require 'file_parser'
  require 'submarine/depth'

  my_submarine = Submarine.new
  depths = FileParser::DepthParser.convert_depths_to_array("part1.txt")
  total_incr = my_submarine.total_depth_increases(depths, Depth.compare_adjacent_depths)
  puts "Total increases is: #{total_incr}"
end

task "depth_calculation_adjacent_sliding_window" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'submarine'
  require 'file_parser'
  require 'submarine/depth'

  my_submarine = Submarine.new
  depths = FileParser::DepthParser.convert_depths_to_array("part1.txt")
  total_incr = my_submarine.total_depth_increases(depths, Depth.compare_adjacent_sliding_window)
  puts "Total increases is: #{total_incr}"
end
