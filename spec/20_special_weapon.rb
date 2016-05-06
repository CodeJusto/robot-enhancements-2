require_relative 'spec_helper'

describe Tatsumaki do
  before :each do
    @tatsu = Tatsumaki.new
  end

  it 'should be a weapon' do
    expect(@tatsu).to be_a(Tatsumaki)
  end

  it 'should have a range of 1' do
    expect(@tatsu.range).to eq(1)  
  end

  it 'should do 30 damage' do
    expect(@tatsu.damage).to eq(30)
  end
end

describe Robot do
  before :each do
    @robot1 = Robot.new(50)
    @robot2 = Robot.new(50)
    @robot3 = Robot.new(50)
    @tatsu = Tatsumaki.new
    @robot2.move_up
    @robot3.move_up
    @robot3.move_right
    @robot1.pick_up(@tatsu)
  end

  it 'should damage 30 to primary target' do
    @robot1.attack(@robot2)
    expect(@robot2.health).to eq(70)
  end

  it 'should do 30 AOE damage to all targets around it' do
    @robot1.attack(@robot2)
    expect(@robot3.health).to eq(70)
  end

  # it 'should do direct damage (bypass shields)' do
  #   @robot1.attack(@robot2)
  #   expect(@robot2.shield).to eq(50)
  #   expect(@robot3.shield).to eq(50)
  # end

end