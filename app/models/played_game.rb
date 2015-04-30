class PlayedGame < ActiveRecord::Base

	validates_uniqueness_of :user, :game => {:scope => :user}

	belongs_to :user
	belongs_to :game
#	attr_accessible :rsvp #boolean
  
  def invite_user(useremail,game)
	if User.find_by_email(useremail) then
			User.find_by_email(useremail).games << game
			return "User invited!"
	else
		return "That user does not have an account. Ask them to join in order for them to receive invitations."	
	end
  end
  

  def rsvp
   	rsvp = true
  end

end
