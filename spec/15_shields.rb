require_relative 'spec_helper'

describe Robot do   
  describe '#wound' do
    before :each do
      @robot = Robot.new(50)
    end

    it 'should start with a default shield of 50' do
      expect(@robot.shield).to eq(50)
    end

    it 'should not damage health when shields are up' do
      @robot.wound(20)
      expect(@robot.health).to eq(100)
    end

    it 'should reduce shield available' do
      @robot.wound(20)
      expect(@robot.shield).to eq(30)
    end

    it 'should damage health when shields are empty' do
      @robot.wound(70)
      expect(@robot.shield).to eq(0)
      expect(@robot.health).to eq(80)
    end
  end
end