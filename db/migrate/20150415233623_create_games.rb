class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :shattered_empire
      t.boolean :shards_of_the_throne
      t.integer :number_of_players
      t.string :races
      t.string :rules
      t.string :strategy_cards
      t.string :players

      t.timestamps null: false
    end
  end
end
