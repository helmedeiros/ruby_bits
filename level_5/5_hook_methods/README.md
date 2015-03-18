LEVEL 5 - Modules
=================

Object Extend
-------------

Extend the single game object with the Playable module, so we can call the play method on it.

```ruby
  module Playable
    def play
    end
  end
```

```ruby
  game = Game.new("Contra")
  game.play
```
