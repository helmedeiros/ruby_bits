LEVEL 2 - Methods and Classes
=============================

attr_accessor
---------------------

Whoever created the game object will want to be able to access the name, year and system for the game, but that doesn't mean we need to make getter methods for them. Refactor the code below to make these variables available using the Ruby way with attr_accessor.

```ruby
class Game
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end

  def name
    @name
  end

  def year
    @year
  end

  def system
    @system
  end
end

```
