class LeaguesController < ApplicationController
	 before_filter :authenticate_user!
	def index
		@leagues = League.includes(:users).sort_by_user(params[:page],params[:search])
	end

	def new
		@league = League.new
	end

	def create_league
		unless current_user.leagues.count > 5
			league = current_user.leagues.create(league_params)
			league.admin_id = current_user.id
			if league.save
				redirect_to leagues_path, notice: "New League created successfully!"
			else
				flash[:error] = "Some error prevented creating league, try another name"
				redirect_to new_league_path
			end
		else
			redirect_to new_league_path, notice: "Only 5 leagues per user."
		end	

	end

	def show
		@league =  League.find(params[:id])
		@toppers = @league.users.order("coins DESC").first(10)
		@requests = @league.requests.where(new: true).order("created_at DESC")
	end

	def admin_portal
		@leagues = current_user.leagues.where(admin_id: current_user.id).page(params[:page]).per(10)
	end

	def admin_show
		@league =  League.find(params[:id])
		@toppers = @league.users.order("coins DESC").page(params[:page]).per(10)
		@requests = @league.requests.where(new: true).order("created_at DESC")
	end

	def join_league
		@league = League.find_by(url: params[:league_url])
		unless @league.users.include?(current_user) 
			req = current_user.requests.new(league_id: @league.id, new: true)
			if @league.request_placed(current_user)
				if req.save
					redirect_to leagues_path, notice: "Request send"
				else
					redirect_to league_path(@league.id), alert: "Request not send, try again."
				end
			else
				redirect_to leagues_path, alert: "Request already placed"
			end
		else
			redirect_to leagues_path, alert: "Already member"
		end
	end

	def delete_league
		leag = League.find(params[:id])
		if current_user.id == leag.admin_id
			leag.destroy
		end
		redirect_to leagues_path, alert: "League deleted !"

	end


	def remove_user
		league = League.find(params[:league_id])
		
		user_league = UserLeague.where("user_id = ? AND league_id = ?", params[:user_id],params[:league_id])
		requests = Request.where("user_id = ? AND league_id = ?", params[:user_id],params[:league_id])
		unless params[:user_id] == league.admin_id
			user_league[0].destroy
			requests[0].destroy
		end
		redirect_to league_path(params[:league_id]), alert: "User Removed !!"
	end

	def accept_request
		req = Request.find(params[:id])
		req_user = req.user 
		req_league = req.league
		if req_league.admin_id == current_user.id 
			unless req_league.users.include?(req_user)
				UserLeague.create(user_id: req_user.id, league_id: req_league.id)
				req.update_attributes(new: false)
			end
			redirect_to league_path(req_league.id), notice: "Request Accepted"
		else
			redirect_to leagues_path, notice: "Not authorised to perform this action"
		end
	end

	def delete_request
		req = Request.find(params[:id])
		req_league = req.league
		if req_league.admin_id == current_user.id
			req.destroy
			redirect_to admin_show_league_path(req_league.id), notice: "Request Deleted"
		else
			redirect_to leagues_path, notice: "Not authorised to perform this action"
		end 
	end

	def my_leagues
		@leagues = current_user.leagues.page(params[:page]).per(10)
	end

	private 

	def league_params
		params.require(:league).permit(:name)
	end

end
