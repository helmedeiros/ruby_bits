class Game
  attr_accessor :name, :year, :system
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end
end

street_fight = Game.new("Street Fight", {:year => 2104, :system => 'PS3'})

puts street_fight.name
puts street_fight.year
puts street_fight.system