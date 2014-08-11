class AdminsController < ApplicationController

	def index
		@bet_matches = BetMatch.where('completed = ?', false)
	end

	def remove_bets
		authorize @bet_matches = BetMatch.all
		BetMatch.destroy_all
		@bet_fixtures = BetFixture.where(bet_created: true)
		unless @bet_fixtures.empty?
			@bet_fixtures.each do |bet_fixture|
				bet_fixture.bet_created = false
				bet_fixture.result = nil
				bet_fixture.save
			end
		end
		redirect_to admins_path

	end
	
end
