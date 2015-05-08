class AddRaceSeatToPlayedGame < ActiveRecord::Migration
  def change
  	 add_column :played_games, :race, :string
  	 add_column :played_games, :seat, :integer
  end
end
