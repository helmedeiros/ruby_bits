require_relative 'game'
require_relative 'game_utils'

class Game
  include GameUtils
end

game = Game.new("Contra")
game.lend_to_friend("helmedeiros@twitter.com")
