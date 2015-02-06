def new_game(name, options = {})
  {
    name: name,
    year: options[:year],
    system: options[:system]
  }
end
street_fight = new_game("Street Figher II",
  :system => "SNES",
  :year => 1992)

fifa2014 = new_game("Fifa",
  :system => "PS3",
  :year => 2014)


games = []
games << street_fight
games << fifa2014

games.each { |n| puts n}
