LEVEL 5 - Modules
=================

ActiveSupport::concern - Part2
------------------------------

Call the included method from inside the LibraryUtils module and pass in a block that calls the load_game_list class method.

```ruby
  module LibraryUtils

    extend ActiveSupport::Concern

    def add_game(game)
    end

    def remove_game(game)
    end

    module ClassMethods
      def search_by_game_name(name)
      end

      def load_game_list

      end
    end
  end

  class AtariLibrary
    include LibraryUtils
  end
```
