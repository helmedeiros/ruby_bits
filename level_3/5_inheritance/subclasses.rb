class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def format
    [@name, @year, @system].compact.join(', ')
  end
end

class ArcadeGame < Game
end

class ConsoleGame < Game
end

pacManArcade = ArcadeGame.new('Pac Man', {:year => 1980, :system => 'ARCADE'})
fifa2014PS3 = ConsoleGame.new('Fifa', {:year => 2014, :system => 'PS3'})

puts pacManArcade.format
puts fifa2014PS3.format
