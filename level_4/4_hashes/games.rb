def difference_between(player1, player2)
  difference = (player1.size > player2.size) ? player1.to_a - player2.to_a : player2.to_a - player1.to_a
  Hash[*difference.flatten]
end

mario_favorite = {
  sports: "Mario Sports Mix",
  action: "Super Mario World"
}

luigi_favorite = {
  sports: "Golf",
  action: "Super Mario World"
}

puts difference_between(mario_favorite, luigi_favorite)
