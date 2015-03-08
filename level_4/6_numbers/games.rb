require 'active_support/all'

def describe_count(games)
if games.empty?
  "You have no games"
elsif games.length.even?
  "You have an even number of games"
elsif games.length.odd?
  "You have an odd number of games"
end
end

games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts describe_count(games)
