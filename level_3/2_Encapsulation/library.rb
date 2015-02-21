class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(search)
    for game in games
      return true if game == search
    end
    false
  end
end


class Game
  attr_accessor :name, :year, :system
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end

  def format
    [@name, @year, @system].compact.join(', ')
  end

  def ==(game)
    @name == game.name &&
    @year == game.year &&
    @system == game.system
  end
end

fifa2013 = Game.new('Fifa', {:year => 2013, :system => 'PS3'})
fifa2014 = Game.new('Fifa', {:year => 2014, :system => 'PS3'})
gta = Game.new('GTA', {:year => 2012, :system => 'PS2'})

puts fifa2013.format
puts fifa2014.format
puts gta.format

puts "fifa 2013 is equals to fifa 2014 ? #{fifa2013 == fifa2014}"
puts "fifa 2013 is equals to fifa 2013 ? #{fifa2013 == fifa2013}"

my_games = Library.new([fifa2013, gta])
puts "Do I have fifa2014 among my games? #{my_games.has_game? fifa2014}"
