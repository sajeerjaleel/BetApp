class LeaguesController < ApplicationController
	
	def index
		@leagues = League.includes(:users).sort_by_user(params[:page],params[:search])
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
			flash[:error] = "Some error prevented creating league, try another name"
			redirect_to new_league_path
		end

	end

	def show
		@league =  League.find(params[:id])
		@toppers = @league.users.order("coins DESC").first(10)
	end

	def admin_portal
		@leagues = current_user.leagues.where(admin_id: current_user.id).page(params[:page]).per(10)
	end

	def admin_show
		@league =  League.find(params[:id])
		@toppers = @league.users.order("coins DESC").page(params[:page]).per(10)
	end

	def remove_user
		league = League.find(params[:league_id])
		
		user_league = UserLeague.where("user_id = ? AND league_id = ?", params[:user_id],params[:league_id])
		unless params[:user_id] == league.admin_id
			user_league[0].destroy
		end
		redirect_to admin_show_league_path(params[:league_id])
	end

	private 

	def league_params
		params.require(:league).permit(:name)
	end

end
