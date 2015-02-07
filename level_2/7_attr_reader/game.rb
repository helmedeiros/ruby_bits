class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
    @created_at = Time.new
  end
end

street_fight = Game.new('Street Fight', {:year => 2014, :system => 'PS3'})
puts street_fight.name
puts street_fight.created_at