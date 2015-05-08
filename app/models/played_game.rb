class PlayedGame < ActiveRecord::Base

	validates_uniqueness_of :user, scope: [:rsvp, :game]
    validate :dont_invite_host

	belongs_to :user
	belongs_to :game

	def dont_invite_host
    	errors.add(:user, "You cannot invite the host.") if
  			user === game.host	
	end
end
