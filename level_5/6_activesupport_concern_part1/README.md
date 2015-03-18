LEVEL 5 - Modules
=================

ActiveSupport::concern - Part1
------------------------------

Now refactor the following code to use ActiveSupport::Concern's ability to expose class methods from a module.

```ruby
  module LibraryUtils

    def self.included(base)
      base.extend(ClassMethods)
    end

    def add_game(game)
    end

    def remove_game(game)
    end

    module ClassMethods
      def search_by_game_name(name)
      end
    end
  end

  class AtariLibrary
    include LibraryUtils
  end
```
