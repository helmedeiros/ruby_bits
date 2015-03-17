LEVEL 5 - Modules
=================

Namespacing
-----------

Create a module named GameUtils and place the lend_to_friend method inside the module. Change lend_to_friend to a class method by prefixing it with self.. You won't need to require this module since it'll be inside the same file(already required), but you will have to namespace your method call.

```ruby
  class Game
    def initialize(name)
      @name = name
    end
  end

  def lend_to_friend(game, friend_email)

  end

  game = Game.new("Contra")
  lend_to_friend(game, "helmedeiros@twitter.com")
```
