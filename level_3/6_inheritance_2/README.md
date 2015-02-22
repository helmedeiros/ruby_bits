LEVEL 3 - Encapsulation, instance & private methods, inheritance, and refactoring
=================================================================================

Inheritance II
--------------

For our ArcadeGame class, we'll also want to track the weight of these giant cabinets taking up all of our available space. Luckily we thought ahead: we already take in an options parameter that we can stick weight into! Override the initialize method for ArcadeGame to take in the same parameters as its parent class, call super, and then set weight.

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
