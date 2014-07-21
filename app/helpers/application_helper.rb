module ApplicationHelper

	def display_image(user)
		if user.image
			"<img src=\"data:image/jpeg;base64,#{user.image}\" style= \"height: 80px; width: 100px;\">".html_safe
		else
			image_tag "avatar.png", height: "80", width: "100"
		end
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

end
