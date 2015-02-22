class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(search_game)
    for game in games
      return true if game == search_game
    end
    false
  end

  def add_game(game)
    self.games << game
  end
end

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

fifa2014 = Game.new('Fifa', {:year => 2014, :system => 'PS3'})
fifa2013 = Game.new('Fifa', {:year => 2013, :system => 'PS3'})
gta = Game.new('GTA', {:year => 2012, :system => 'PS3'})

my_library = Library.new([fifa2013, fifa2014])
puts "First games!"
my_library.games.each { |game| puts game.format}

my_library.add_game(gta)
puts "First games with more games!"
my_library.games.each { |game| puts game.format}
