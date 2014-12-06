# Unless
# We're putting together a system to manage our vast video game collection that we just can't seem to part with.
# Using if with negative conditions can be tough to read. Refactor the code below to use unless rather than if.
games = ["Super M ario Bros.", "Contra", "Metroid", "Mega Man 2"]
unless games.empty?
  puts "Games in your vast collection: #{games.count}"
end
