# Implied nil
# Let's implement a simple search feature - for our naive implementation, we search for a game by its exact title, and if it's found, we show it.
# Comparing something with nil in an if statement isn't needed in Ruby. Refactor the code below to run without the nil comparison.
search = "Contra"
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
search_index = games.find_index(search)
puts "Game #{search} Found: #{games[search_index]} at index #{search_index}." if search_index
puts "Game #{search} not found." unless search_index
