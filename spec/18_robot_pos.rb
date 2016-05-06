require_relative "spec_helper"

describe Robot do
  before :each do
    Robot.clear
    @robot1 = Robot.new(50)
    @robot2 = Robot.new(50)
  end

  it 'should retun an array of everyone at 0,0' do
    expect(Robot.scan(0, 0)).to match_array([@robot1, @robot2])
  end

  it 'should return an empty array at an empty location' do
    expect(Robot.scan(5, 5)).to match_array([])
  end

end