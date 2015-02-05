LEVEL 2 - Methods and Classes
=============================

Options Hash Argument
---------------------

Defaulting two arguments to nil isn't ideal. Update the method signature and implementation to take an optional options hash with keys for :year and :system.

```ruby
def new_game(name, year=nil, system=nil)
  {
    name: name,
    year: year,
    system: system
  }
end
game = new_game("Street Figher II", "SNES", 1992)
```
