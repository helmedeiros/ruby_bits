LEVEL 5 - Modules
=================

ActiveSupport::concern - Part3
------------------------------

Make sure the AtariLibrary class includes only the LibraryUtils module and let ActiveSupport::Concern take care of loading its dependencies. Then, refactor the self.included method on LibraryUtils to use the included method.

```ruby
  module LibraryLoader
    extend ActiveSupport::Concern

    module ClassMethods
      def load_game_list
      end
    end
  end

  module LibraryUtils
    def self.included(base)
      base.load_game_list
    end
  end

  class AtariLibrary
    include LibraryLoader
    include LibraryUtils
  end
```
