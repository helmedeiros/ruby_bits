class Library
  attr_reader :games
  def initialize(games)
    @games = games
  end
end


class Game
  attr_accessor :name, :year, :systems
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end

  def format
    [@name, @system, @year].compact.join(', ')
  end
end

fifa2014 = Game.new('Fifa 2014', {:year => 2014,  :system => 'PS3'})
gta = Game.new('GTA', {:year => 2012,  :system => 'PS3'})


my_games = Library.new([fifa2014, gta])
my_games.games.each { |n| puts n.format}
