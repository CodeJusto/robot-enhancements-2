class Robot

  attr_reader :position, :items_weight, :health
  attr_accessor :equipped_weapon

  @@max_weight = 250
  @@max_health = 100

  def initialize()
    @position = [0, 0]
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
    @item_array = []
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def items(item=nil)
    unless item.nil?
      @item_array << item
      @items_weight += item.weight
    end
    @item_array
  end

  def pick_up(item)
    return false if (items_weight + item.weight) > @@max_weight
    items(item)
    @equipped_weapon = item if item.is_a?(Weapon)
    item.feed(self) if item.is_a?(BoxOfBolts) && self.health <= 80
    true
  end

  def wound(damage)
    @health -= damage
    @health = 0 if health < 0
  end

  def heal(amount)
    @health += amount
    @health = @@max_health if health > @@max_health
  end

  def heal!(amount)
    raise "Target is already dead!" if health <= 0
    @health += amount
    @health = @@max_health if health > @@max_health
  end

  def attack(target)
    return nil unless self.proximity_check?(target)
    if equipped_weapon == nil 
      target.wound(5) 
    else
      equipped_weapon.hit(target)
      @equipped_weapon = nil if equipped_weapon.is_a?(Grenade)
    end
  end

  def proximity_check?(target)
    (target.position - self.position).any? {|position| position.abs <= equipped_weapon.range}
  end
end
