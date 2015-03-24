require 'active_support/all'

module LibraryLoader
  extend ActiveSupport::Concern

  module ClassMethods
    def load_game_list
      puts "Loading game list"
    end
  end
end
