LEVEL 3 - Encapsulation, instance & private methods, inheritance, and refactoring
=================================================================================

Inheritance
-----------

Our game class is getting a little overloaded trying to handle both console games and our old arcade console units (which are really heavy, by the way). Let's create two subclasses of Game: one for ArcadeGame and another for ConsoleGame.

```ruby
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end
end
```
