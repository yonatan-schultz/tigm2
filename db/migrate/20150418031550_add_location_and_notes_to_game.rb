class AddLocationAndNotesToGame < ActiveRecord::Migration
  def change
  	add_column :games, :address, :string
  	add_column :games, :notes, :text
  	add_column :games, :date_and_time, :datetime
  end
end
