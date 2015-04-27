class Game < ActiveRecord::Base

	belongs_to :host, class_name: 'User'
	has_many :played_games
	has_many :users, :through => :played_games

	validates :number_of_players, :presence => true
	validate :must_have_enough_races, :if => :active_or_races?
	validate :must_have_eight_strategy_cards, :if => :active_or_strategy_cards?
	validate :must_have_objectives, :if => :active_or_strategy_cards?
	validate :must_select_trade_iii, :if => :playing_with_mercs?
	validate :must_select_assembly_ii, :if => :playing_with_political_intrigue?

	def select_races
		races = ["The Emirates of Hacan","The Universities of Jol-Nar","The Barony of Letnev","The Sardakk N'orr","The Federation of Sol","The Xxcha Kingdom","The L1Z1X Mindnet","The Mentak Coalition","The Naalu Colletive","The Yssaril Tribes"]
		if self.shattered_empire == true then races.push("The Embers of Muatt","The Clan of Saar","The Winnu","The Yin Brotherhood") end
		if self.shards_of_the_throne == true then races.push("The Arborec","The Ghosts of Creuss","The Nekro Virus") end
		return races
	end

	def select_rules
		rules = ["The Long War","Age Of Empire","Distant Suns","Leaders","Sabotage Runs"]
		if self.shattered_empire == true then rules.push("Race-Specific Technologies","Artifacts","Shock Troops","Space Mines","The Wormhole Nexus","Facilities","Tactical Retreats","Territorial Distant-Suns","Custodians of Mecatol Rex","Voice of the Council","Simulated Early Turns") end
		if self.shards_of_the_throne == true then rules.push("Preliminary Objectives","Flagships","The Final Frontier","Mechanized Units","Mercenaries","Political Intrigue") end
		return rules
	end

	def select_strategy_cards
		#this should really be a hash Initiative => 1, etc
		strategy_cards = {"Initiative" => 1, "Diplomacy" => 2, "Political" => 3, "Logistics" => 4, "Trade" => 5, "Warfare" => 6, "Technology" => 7,"Imperial" => 8}
		if self.shattered_empire == true then strategy_cards.merge!("Leadership" => 1,"Diplomacy II" => 2,"Assembly" => 3,"Production" => 4,"Trade II" => 5,"Warfare II" => 6,"Technology II" => 7,"Bureaucracy" => 8,"Imperial II" =>8) end
		if self.shards_of_the_throne == true then strategy_cards.merge!("Trade III" => 5,"Political II" => 3,"Assembly II" => 3) end
		return strategy_cards
	end

	def active?
  		status == 'active'
	end

 	def active_or_races?
		status.include? "races" || active?
	end

	def active_or_rules?
		status.include? "rules" || active?
	end

	def active_or_strategy_cards?
		status.include? "strategy" || active?
	end

	def must_have_enough_races
		errors.add(:races, "must have enough races for all players") if 
			eval(races).length < number_of_players		
	end

	def must_have_eight_strategy_cards
		errors.add(:strategy_cards, "must have eight strategy cards") if 
			eval(strategy_cards).length != 8	
	end		

	def must_have_objectives
	## Must choose a strat which allows objectives to get out unless has selected Age of Empirere
    ## Means imperial, bureaucracy
    	errors.add(:strategy_cards, "you must select a strategy card which allows you to get objectives onto the table (Imperial or Bureaucracy) unless playing with Age of Empire optional rule.") unless
  			!strategy_cards.include?("Imperial II") || strategy_cards.include?("Bureaucracy") || rules.include?("Age of Empire")  		
	end

	def playing_with_mercs?
		 ( status.include? "strategy" || active? ) && rules.include?("Mercenaries")
	end

	def must_select_trade_iii
    ## Must choose trade III if using Mercenaries
    	errors.add(:strategy_cards, "you must select Trade III if you are choosing to play with the Mercenaries optional rule.") unless
    	 	  strategy_cards.include?("Trade III")
    end

    def playing_with_political_intrigue?
		 ( status.include? "strategy" || active? ) && rules.include?("Political Intrigue")
    end

    def must_select_assembly_ii
    ## Must choose Assembly II if using Political Intrigue
    	errors.add(:strategy_cards, "you must select Assembly II if you are choosing to play with the Political Intrigue optional rule.") unless
    	 	  strategy_cards.include?("Assembly II")    
    end 	

end
