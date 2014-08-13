module ApplicationHelper

	def display_image(user)
		if user.image
			"<img class=\"img-circle\" src=\"data:image/jpeg;base64,#{user.image}\" style= \"height: 40px; width: 40px;\">".html_safe
		else
			image_tag "avatar.png", height: "50", width: "50"
		end
	end

	def display_image_normal(user)	
		image_tag "avatar.png", height: "80", width: "100"
	end

	def home_image(bet_match)
		image_name = bet_match.bet_fixture.home_team
		image_name+".png"
	end

	def join_league(user)
		 (link_to "Join", join_league_path(league_url: @league.url), style: "color:green;font-weight:700;font-size:18px;") unless @league.users.include?(user)
	end

	def away_image(bet_match)
		image_name = bet_match.bet_fixture.away_team
		image_name+".png"
	end

	def placed_bet(fixture_id)
		current_user.bet_completed?(fixture_id)
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

	def result bet
    @fixture = BetFixture.find params[:id]
    @bets    = @fixture.bets
    @user    = current_user
    user_bets = current_user.bets.where(bet_fixture_id: @fixture.id)
    user_home_bet = user_bets.where(prediction: "home")
		user_draw_bet = user_bets.where(prediction: "draw")
		user_away_bet = user_bets.where(prediction: "away")
    
    @home_bets = @bets.where(prediction: "home")
    @draw_bets = @bets.where(prediction: "draw")
    @away_bets = @bets.where(prediction: "away")

    @total_coins = @bets.sum(:coins)
    user_home_coins = user_home_bet.first.coins rescue nil
    user_draw_coins = user_draw_bet.first.coins rescue nil
    user_away_coins = user_away_bet.first.coins rescue nil
    @home_coins  = @home_bets.sum(:coins)
    @draw_coins  = @draw_bets.sum(:coins)
    @away_coins  = @away_bets.sum(:coins)

    if bet == "home"
        @user_share = (user_home_coins.to_f / @home_coins.to_f) rescue nil
        @user_win_coin = @user_share * @total_coins rescue nil
    elsif bet == "draw"
        @user_share = (user_draw_coins  / @draw_coins.to_f) rescue nil
        @user_win_coin = @user_share * @total_coins rescue nil
    elsif bet == "away"
        @user_share = (user_away_coins  / @away_coins.to_f) rescue nil
        @user_win_coin = @user_share * @total_coins rescue nil
    end
    return @user_win_coin.to_i rescue nil
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
  		link_to "", remove_user_path(league_id: @league.id,user_id: user.id) ,method: "delete", 
		  class: "glyphicon glyphicon-trash remove", :style => "color:red;"
		else
			"N/A"
		end
	end

	def user_bets (bet)
		@fixture = BetFixture.find params[:id]
		user_bets = current_user.bets.where(bet_fixture_id: @fixture.id)
		user_home_bet = user_bets.where(prediction: "home")
		user_draw_bet = user_bets.where(prediction: "draw")
		user_away_bet = user_bets.where(prediction: "away")
			if bet == "home"
				return user_home_bet.first.coins rescue nil
			elsif bet == "draw"
				return user_draw_bet.first.coins rescue nil
			elsif bet == "away"
				return user_away_bet.first.coins rescue nil
			end
	end

	def atleast_one_bet
		@fixture = BetFixture.find params[:id]
		return current_user.bets.where(bet_fixture_id: @fixture.id).count
	end

	def bet_history_team bet
		if bet.prediction == "home"
			return bet.bet_fixture.home_team
		elsif bet.prediction == "draw"
			return "Draw"
		elsif bet.prediction == "away"
			return bet.bet_fixture.away_team
		end
	end

	def fav_team_icon user
		if user.fav_team == "Man United"
			image_tag "Man Utd.png" , :width => "25px", :height => "25px"
		elsif user.fav_team == "Tottenham"
			image_tag "Spurs.png" , :width => "25px", :height => "25px"
			return nil
		else
			image_tag "#{user.fav_team}.png" , :width => "25px", :height => "25px"
		end
	end

end
