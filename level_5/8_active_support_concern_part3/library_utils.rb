require 'active_support/all'
require_relative 'library_loader'

module LibraryUtils
  extend ActiveSupport::Concern
  include LibraryLoader

  included do
    load_game_list
  end
end
