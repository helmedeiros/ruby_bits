class Game
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

def lend_to_friend(game, friend_email)
  puts "Lending #{game.name} to #{friend_email}"
end

game = Game.new("Contra")
lend_to_friend(game, "helmedeiros@twitter.com")
