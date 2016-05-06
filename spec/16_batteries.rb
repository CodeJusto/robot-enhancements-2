require_relative 'spec_helper'
# detect |  }
describe Battery do 
  before :each do
    @battery = Battery.new
  end

  it 'should be an item' do
    expect(@battery).to be_a(Item)
  end

  it 'should have a weight of 25' do
    expect(@battery.weight).to eq(25)
  end

  it 'should fully recharge shields if picked up' do
    robot = Robot.new(50)
    robot.pick_up(@battery)
    robot.wound(50)
    robot.recharge
    expect(robot.shield).to eq(50)
  end

  it 'should not do anything if not picked up' do
    robot = Robot.new(50)
    robot.wound(50)
    expect(robot.recharge).to be_nil
  end

end
  
