require 'submarine'
require 'file_parser'

RSpec.describe FileParser::DirectionParser do
  let (:submarine) {
    Submarine.new
  }
  describe ".execute_movement" do
    it "executes an 'down' movement with value n" do
      FileParser::DirectionParser.execute_movement(:down, 4, submarine)
      expect(submarine.aim).to eq(4)
    end
    it "executes an 'up' movement with value n" do
      FileParser::DirectionParser.execute_movement(:up, 2, submarine)
      expect(submarine.aim).to eq(-2)
    end
    it "executes an 'forward' movement with value n" do
      submarine.aim = 4
      FileParser::DirectionParser.execute_movement(:forward, 4, submarine)
      expect(submarine.horz).to eq(4)
      expect(submarine.depth).to eq(16)
    end
  end
end
