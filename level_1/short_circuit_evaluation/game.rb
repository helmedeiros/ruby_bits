# Short-Circuit Evaluation
# Using Short-Circuit Evaluation can clean up your code a great deal.
# Update the following method to use short circuit evaluation. While you're at it, why not try reducing the entire method to one line?
def search_index(games, search_term)
  games.find_index(search_term) || "Not Found"
end

games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts search_index(games, "Contra")
