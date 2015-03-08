LEVEL 4 - Activesupport
=======================

Numbers
-------

Refactor the describe_count method below to use ActiveSupport in order to find out if a number is even or odd.

```ruby
  def describe_count(games)
  if games.empty?
    "You have no games"
  elsif (games.length % 2) == 0
    "You have an even number of games"
  elsif (games.length % 2) != 0
    "You have an odd number of games"
  end
  end

  games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
  puts describe_count(games)


```
