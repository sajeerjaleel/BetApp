class BetFixture < ActiveRecord::Base
	has_one :bet_match
	has_many :bets
	has_many :comments
	
	def bet_data
		date + " " + time + " " + home_team + " vs " + away_team
	end
end
