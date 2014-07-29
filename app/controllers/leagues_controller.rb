class LeaguesController < ApplicationController
	
	def index
		@leagues = League.all.sort_by_user(params[:page],params[:search])
	end

end
