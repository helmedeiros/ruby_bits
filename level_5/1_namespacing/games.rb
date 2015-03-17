class Game
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

module GameUtils
  def self.lend_to_friend(game, friend_email)
    puts "Lending #{game.name} to #{friend_email}"
  end
end

game = Game.new("Contra")
GameUtils.lend_to_friend(game, "helmedeiros@twitter.com")
