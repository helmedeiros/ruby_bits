module LibraryUtils
  def self.included(base)
    base.load_game_list
  end
end
