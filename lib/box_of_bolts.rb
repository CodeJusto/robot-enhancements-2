class BoxOfBolts < Item

  attr_reader :heal_amount

  def initialize(name="Box of bolts", weight = 25, heal_amount = 20)
    super(name, weight)
    @heal_amount = heal_amount
  end

  def feed(robot)
    robot.heal(heal_amount)
  end

end