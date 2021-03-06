require 'active_support/all'

module LibraryUtils
  extend ActiveSupport::Concern

  included do
    load_game_list
  end

  def add_game(game)
    puts "adding #{game.name}"
  end

  def remove_game(game)
    puts "removing #{game.name}"
  end

  module ClassMethods
    def search_by_game_name(name)
      puts "searching #{name}"
    end

    def load_game_list
      puts "loading game list"
    end
  end
end
