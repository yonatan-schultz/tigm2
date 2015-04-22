json.array!(@games) do |game|
  json.extract! game, :id, :shattered_empire, :shards_of_the_throne, :number_of_players, :races, :rules, :strategy_cards, :players
  json.url game_url(game, format: :json)
end
