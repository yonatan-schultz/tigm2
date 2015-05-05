class PlayedGame < ActiveRecord::Base

#	validates_uniqueness_of :user, :game => {:scope => [:user,:rsvp]}

	belongs_to :user
	belongs_to :game

end
