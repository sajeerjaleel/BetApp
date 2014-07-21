class BetFixture < ActiveRecord::Base
	has_one :bet_match
	
	def bet_data
		date + " " + time + " " + home_team + " vs " + away_team
	end
end
