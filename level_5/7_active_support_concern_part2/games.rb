require_relative 'game'
require_relative 'atari_library'

pac_man = Game.new('PacMan')
atari_library = AtariLibrary.new()

atari_library.add_game(pac_man)
atari_library.remove_game(pac_man)
AtariLibrary.search_by_game_name(pac_man.name)
