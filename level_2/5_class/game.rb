class Game
  def initialize(name, options={})
    @name = name
    @system = options[:system]
    @year = options[:year]
  end

  def format
    [@name, @system, @year].compact.join(', ')
  end
end

street_fight = Game.new("Street Fight", { :system => "PS3", :year => "2014"})
puts street_fight.format
