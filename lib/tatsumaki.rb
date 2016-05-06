class Tatsumaki < Weapon

  def initialize(name = "Tatsumaki", weight = 0, damage = 30, range = 1)
    super(name, weight, damage, range)
  end

  def hit(target)
    current_shield = target.shield
    target.shield = 0
    super
    target.shield = current_shield
  end
end