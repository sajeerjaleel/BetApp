class BetFixture < ActiveRecord::Base
	belongs_to :bet_match

	def bet_data
		date + " " + time + " " + home_team + " vs " + away_team
	end
end
