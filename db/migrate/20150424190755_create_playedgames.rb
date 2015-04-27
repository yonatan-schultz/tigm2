class CreatePlayedgames < ActiveRecord::Migration
  def change
    create_table :played_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :rsvp, :default => false
      t.timestamps null: false
    end
  end
end
