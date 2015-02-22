LEVEL 3 - Encapsulation, instance & private methods, inheritance, and refactoring
=================================================================================

Inheritance III
---------------

Whenever we output a game right now it'll show up using the to_s method from Object, the parent object of Game. A basic to_s implementation is completed below on Game. Override this for ConsoleGame to also show the system the game is on.

```ruby
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    self.created_at = Time.now
  end

  def to_s
    self.name
  end
end

class ArcadeGame < Game
  attr_accessor :weight
  def initialize(name, options={})
    super
    self.weight = options[:weight]
  end
end

class ConsoleGame < Game

end

```
