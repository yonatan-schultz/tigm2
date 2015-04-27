class PlayedGame < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
#	attr_accessible :rsvp #boolean
end
