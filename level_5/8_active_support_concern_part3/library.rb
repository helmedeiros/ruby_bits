require_relative 'library_utils'
require_relative 'library_loader'
require_relative 'atari_library'

library = AtariLibrary.new
library.load_game_list
