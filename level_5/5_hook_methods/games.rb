require_relative 'atari_library'
require_relative 'game'

pac_man = Game.new("pacMan")


atari_library = AtariLibrary.new()
atari_library.add_game(pac_man)
