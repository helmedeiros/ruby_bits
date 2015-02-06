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

puts fifa2014
puts street_fight
