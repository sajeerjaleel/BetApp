class LeaguesController < ApplicationController
	
	def index
		@leagues = League.sort_by_user(params[:page],params[:search])
	end

	def new
		@league = League.new
	end

	def create_league
		league = current_user.leagues.create(league_params)
		league.admin_id = current_user.id
		if league.save
			redirect_to leagues_path
		else
			flash[:error] = "Some error prevented creating league"
			redirect_to new_league_path
		end

	end

	private 

	def league_params
		params.require(:league).permit(:name)
	end

end
