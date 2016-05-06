require_relative 'spec_helper'

describe Robot do
  before :each do
    Robot.clear
    @robot1 = Robot.new(50)
  end

  it 'should return an empty array if no one there' do
    @robot1.move_up
    @robot1.move_up
    expect(@robot1.sweep_check).to eq(false)
  end

  it 'should find a robot to the north' do
    robot2 = Robot.new(50)
    robot2.move_up
    expect(@robot1.sweep_check).to match_array([robot2])
  end

  it 'should find two robots around it' do
    robot2 = Robot.new(50)
    robot3 = Robot.new(50)
    robot2.move_up
    robot3.move_right
    expect(@robot1.sweep_check).to match_array([robot2, robot3])
  end
end