require_relative 'game'
require_relative 'playable'

game = Game.new("contra")
game.extend(Playable)
game.play
