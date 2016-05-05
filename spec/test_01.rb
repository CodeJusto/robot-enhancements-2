require_relative 'spec_helper'

describe Robot do
  describe '#heal' do
    before :each do
      @robot = Robot.new
    end

    it 'should heal when alive' do
      @robot.heal!(20)
      expect(@robot.health).to eq(100)
    end

    it 'should not heal when dead' do
      expect(@robot).to receive(:health).and_return(0)
      # binding.pry
      expect(@robot.heal!(30)).to raise_error(RuntimeError)
    end

  end
end