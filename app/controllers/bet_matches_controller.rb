class BetMatchesController < ApplicationController
	def new
		@bet_match = BetMatch.new
		@fixtures = BetFixture.where('bet_created = ?', false).first(20)
	end

	def create
		BetMatch.create(bet_match_params)
		redirect_to admins_path
	end

	private

	def bet_match_params
		params.require(:bet_match).permit(:bet_fixture_id)
	end
end
