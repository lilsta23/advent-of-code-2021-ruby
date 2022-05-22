module FileParser
  module DepthParser
    def self.convert_depths_to_array(filename)
      File.read("files/#{filename}").split.map{|x| x.to_i}
    end
  end

  module DirectionParser
    def self.perform_submarine_movements(filename, submarine)
      File.new("files/#{filename}", chomp: true).readlines.each do |line|
        # split into a movement
        movement, value = line.split
        execute_movement(movement.to_sym, value.to_i, submarine)
      end
    end

    def execute_movement(movement, value, submarine)
      case movement
      when :forward
        submarine.go_forward value
      when :up
        submarine.go_up value
      when :down
        submarine.go_down value
      end
    end

    module_function :execute_movement
  end

  module BinaryDiagnosticParser
    def self.convert_binary_numbers_to_array(filename)
      File.read("files/#{filename}").split
    end
  end
end
