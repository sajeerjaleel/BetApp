class BetMatchesController < ApplicationController
	def new
		@bet_match = BetMatch.new
		@fixtures = BetFixture.where('bet_created = ?', false).first(20)
	end

	def index
		@bet_matches = BetMatch.includes(:bet_fixture).where('done = ?', false)
	end

	def edit
		@bet_match = BetMatch.includes(:bet_fixture).find params[:id]
	end

	def update
		@bet_match = BetMatch.find params[:id]
		@bet_match.update_attributes(bet_match_params)
		redirect_to admins_path
	end

	def create
		BetMatch.create(bet_match_params)
		redirect_to admins_path
	end

	private

	def bet_match_params
		params.require(:bet_match).permit(:bet_fixture_id,:completed,:done,{:bet_fixture_attributes => [:id, :result]})
	end
end
