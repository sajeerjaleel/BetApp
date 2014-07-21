class AdminsController < ApplicationController

	def index
		@bet_matches = BetMatch.where('completed = ?', false)
	end
	
end
