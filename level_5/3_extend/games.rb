require_relative 'game'
require_relative 'game_utils'

class Game
  extend GameUtils
end

Game.find_all_from_user("Gregg")
