LEVEL 2 - Methods and Classes
=============================

attr_reader
---------------------

When a game is initialized, store another variable called created_at which is set to Time.now in the initialize method. Make sure it can be accessed, but that it cannot be set from outside the object.

```ruby
class Game
  attr_accessor :name, :year, :system

  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end
end
```
