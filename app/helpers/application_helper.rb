module ApplicationHelper

	def display_image(user)
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

	def away_image(bet_match)
		image_name = bet_match.bet_fixture.away_team
		image_name+".png"
	end

end
