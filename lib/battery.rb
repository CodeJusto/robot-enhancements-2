class Battery < Item

  def initialize(name = "Battery", weight = 25)
    super(name, weight)
  end

  def recharge(robot)
    robot.recharge
  end


end