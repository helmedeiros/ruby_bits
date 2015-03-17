LEVEL 5 - Modules
=================

Mixin
-----

Re-open the Game class and include the GameUtils module so its methods are exposed as instance methods. Make sure to do this before it is called.

```ruby
  class Game
    def initialize(name)
      @name = name
    end
  end
```

```ruby
  module GameUtils
    def lend_to_friend(friend_email)
    end
  end
```

```ruby
  game = Game.new("Contra")
  game.lend_to_friend("helmedeiros@twitter.com")
```
