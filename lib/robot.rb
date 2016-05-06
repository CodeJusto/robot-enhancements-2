class Robot

  attr_reader :position, :items_weight, :health
  attr_accessor :equipped_weapon, :shield

  CAPACITY = 250
  MAX_HEALTH = 100
  MAX_SHIELD = 50
  @@all_robots = []

  def initialize(shield = 0)
    @position = [0, 0]
    @items_weight = 0
    @health = MAX_HEALTH
    @equipped_weapon = nil
    @item_array = []
    @shield = shield
    @@all_robots << self
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
    return false unless can_carry?(item)
    items(item)
    @equipped_weapon = item if item.is_a?(Weapon)
    item.feed(self) if item.is_a?(BoxOfBolts) && self.health <= 80
    true
  end

  def can_carry?(item)
    (items_weight + item.weight) <= CAPACITY
  end

  def wound(damage)
      absorbed_damage = damage
      @shield -= absorbed_damage
      damage = overkill(damage, absorbed_damage)
    if shield < 0
      @health -= @shield.abs
      @shield = 0
    end
    @health = damage > health ? 0 : health - damage  
  end

  def overkill(damage, absorbed_damage)
    damage < 0 ? 0 : damage -= absorbed_damage
  end

  def attack(target)
    return nil unless self.proximity_check?(target)
    if equipped_weapon == nil
      target.wound(5) 
    else
      if equipping_tatsu?(equipped_weapon)
        lock_on(target)
      else
        equipped_weapon.hit(target)
      end
      @equipped_weapon = nil if equipped_weapon.is_a?(Grenade)
    end
  end

  def equipping_tatsu?(weapon)
    weapon.is_a?(Tatsumaki)
  end

  def lock_on(target)
    sweep_check(target.position).each {|target| equipped_weapon.hit(target)}
  end

  def proximity_check?(target)
    abs_range = (target.position - self.position)
    return true if abs_range.empty?
    range = range_fixer
    abs_range.any? do |position| 
      position.abs <= range
    end
  end

  def range_fixer
    equipped_weapon == nil ? range = 1 : range = equipped_weapon.range
  end

  def heal(amount)
    @health += amount
    @health = overheal(health)
  end

  def overheal(health)
    health > MAX_HEALTH ? MAX_HEALTH : health
  end

  def heal!(amount)
    raise "Target is already dead!" if health <= 0
    @health += amount
    @health = MAX_HEALTH if health > MAX_HEALTH
  end

  def recharge
    @item_array.any? {|item| item.is_a?(Battery)} ? @shield = MAX_SHIELD : nil
  end

  def sweep_check(target = @position)
    radius = surroundings(target).map {|coords| Robot.scan(coords[0],coords[1])}.flatten
    radius.delete(self)
    radius.empty? ? false : radius
  end

  def surroundings(position_array)
    abs_x = position_array[0]
    abs_y = position_array[1]
    [[abs_x, abs_y+1],[abs_x+1, abs_y], [abs_x, abs_y-1], [abs_x-1, abs_y], [abs_x, abs_y]]
  end

  class << self

    def clear
      @@all_robots = []
    end

    def list
      @@all_robots
    end

    def scan(x,y)
      @@all_robots.select {|robot| robot.position == [x,y]}
    end

  end
end
