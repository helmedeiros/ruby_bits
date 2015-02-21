LEVEL 3 - Encapsulation, instance & private methods, inheritance, and refactoring
=================================================================================

Encapsulation
-------------

We got a little ahead of ourselves and added a has_game? method to Library that takes in the name of a game. Then, we realized that it doesn't compare year or system! Rather than passing in a game name to the has_game? method, pass in an instance of a game, and check for equality with the entire game object using the declared == method on Game.

```ruby
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(search_name)
    for game in games
      return true if game.name == search_name
    end
    false
  end
end
```
