module ApplicationHelper

	def display_image(user)
		if user.image
			"<img class=\"img-circle\" src=\"data:image/jpeg;base64,#{user.image}\" style= \"height: 40px; width: 40px;\">".html_safe
		else
			image_tag "avatar.png", height: "50", width: "50"
		end
	end

	def display_image_normal(user)
		if user.image
			"<img src=\"data:image/jpeg;base64,#{user.image}\" style= \"height: 80px; width: 100px;\">".html_safe
		else
			image_tag "avatar.png", height: "80", width: "100"
		end
	end

	def home_image(bet_match)
		image_name = bet_match.bet_fixture.home_team
		image_name+".png"
	end

	def join_league(user)
		 (link_to "Join Leage", "#") unless @league.users.include?(user)
	end

	def away_image(bet_match)
		image_name = bet_match.bet_fixture.away_team
		image_name+".png"
	end

	def placed_bet
		@count = 0
		current_user.bets.each do |bet|
			if bet.bet_fixture_id.equal?(@fixture.id ) 
				@count = 1 
				break 
			end 
		end 
		if @count == 0 
			return false
		else
			return true	
		end 
	end

	def predicted_team 
		if @placed_bet.first.prediction == "home"
			return @placed_bet.first.bet_fixture.home_team
		elsif @placed_bet.first.prediction == "away"
			return @placed_bet.first.bet_fixture.away_team
		else
			return "Draw"
		end
	end

	def total_users_bet type
		@home_bets = @fixture_bets.where(prediction: "home")
		@draw_bets = @fixture_bets.where(prediction: "draw")
		@away_bets = @fixture_bets.where(prediction: "away")
		if type == "home_bets"
			return @home_bets.count
		elsif type == "draw_bets"
			return @draw_bets.count
		else
			return @away_bets.count
		end
	end

	def total_coins_bet type
		@home_bets = @fixture_bets.where(prediction: "home")
		@draw_bets = @fixture_bets.where(prediction: "draw")
		@away_bets = @fixture_bets.where(prediction: "away")
		if type == "home_bets"
			coin =@home_bets.sum(:coins)
			return coin
		elsif type == "draw_bets"
			coin =@draw_bets.sum(:coins)
			return coin
		else
			coin =@away_bets.sum(:coins)
			return coin
		end
	end


	def team(pred)
		a = pred == "draw" ? "" : pred + "_team"
		a
	end

	def result 
    @fixture = BetFixture.find params[:id]
    @bets    = @fixture.bets
    @user    = current_user
    @user_bets = current_user.bets.where(bet_fixture_id: @fixture.id)
    @user_bet = @user_bets.first.prediction
    
    @home_bets = @bets.where(prediction: "home")
    @draw_bets = @bets.where(prediction: "draw")
    @away_bets = @bets.where(prediction: "away")

    @total_coins = @bets.sum(:coins)
    @user_coins  = @user_bets.first.coins
    @home_coins  = @home_bets.sum(:coins)
    @draw_coins  = @draw_bets.sum(:coins)
    @away_coins  = @away_bets.sum(:coins)

    if @user_bet == "home"
        @user_share = (@user_coins.to_f / @home_coins.to_f)
        @user_win_coin = @user_share * @total_coins
    elsif @user_bet == "draw"
        @user_share = (@user_coins.to_f  / @draw_coins.to_f)
        @user_win_coin = @user_share * @total_coins
    elsif @user_bet == "away"
        @user_share = (@user_coins.to_f  / @away_coins.to_f)
        @user_win_coin = @user_share * @total_coins
    end
    return @user_win_coin.to_i
  end

  def team_name(id)
  	team = Team.find id
  	team.team_name
  end

  def admin_prevs(user)
  	(link_to "Admin Portal", admin_portal_path) if user.has_admin_prev
  end

  def remove_user(user)
  	unless @league.admin_id == user.id 
  		link_to "Remove User", remove_user_path(league_id: @league.id,user_id: user.id) ,method: "delete", 
		  class: "remove"
		else
			"N/A"
		end
	end

end
