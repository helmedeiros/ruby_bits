module LibraryUtils
  def self.included(base)
    base.extend(ClassMethods)
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
  end
end
