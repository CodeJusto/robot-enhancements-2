require_relative 'spec_helper'

describe Robot do
  before :each do
    Robot.clear
    @robot1 = Robot.new(50)
    @robot2 = Robot.new(50)
  end

  it 'should keep track of all robots' do
    expect(Robot.list).to match_array([@robot1, @robot2])
  end

  it 'should do the same with three robots' do
    @robot3 = Robot.new(50)
    expect(Robot.list).to match_array([@robot1, @robot2, @robot3])
  end


end
